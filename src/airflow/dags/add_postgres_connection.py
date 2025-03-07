from airflow import DAG
from airflow.hooks.base_hook import BaseHook
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from airflow.models import Connection


def add_postgres_connection():
    # Définir la connexion PostgreSQL à l'aide de l'API Airflow
    conn_id = 'postgres_conn'
    conn_type = 'postgres'
    host = 'cic-data-source-postgres'
    schema = 'COM_INGESTION_DB'
    login = 'Admin'
    password = 'Admin123'
    port = '5432'

    # Vérifier si la connexion existe déjà
    existing_conn = BaseHook.get_connection(conn_id)

    if existing_conn:
        print(f"Connexion {conn_id} déjà existante.")
    else:
        # Ajouter la nouvelle connexion PostgreSQL à Airflow
        conn = Connection(
            conn_id=conn_id,
            conn_type=conn_type,
            host=host,
            schema=schema,
            login=login,
            password=password,
            port=port
        )
        conn.create()
        print(f"Connexion {conn_id} ajoutée avec succès.")


def check_tables_exist():
    # Créer une connexion PostgreSQL via PostgresHook
    hook = PostgresHook(postgres_conn_id='postgres_conn')

    # Requête SQL pour lister les tables de la base de données
    sql = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';"

    # Exécuter la requête et récupérer les résultats
    records = hook.get_records(sql)

    if records:
        print(f"Tables trouvées : {', '.join([record[0] for record in records])}")
    else:
        print("Aucune table trouvée !")
        raise ValueError("Aucune table trouvée dans la base de données.")


# Définir le DAG
with DAG(
        'check_postgres_tables',
        default_args={'owner': 'airflow', 'retries': 1},
        description='Un DAG pour ajouter une connexion PostgreSQL et vérifier les tables',
        schedule_interval=None,
        start_date=days_ago(1),
        catchup=False,
) as dag:
    # Tâche pour ajouter la connexion
    add_connection_task = PythonOperator(
        task_id='add_postgres_connection',
        python_callable=add_postgres_connection
    )

    # Tâche pour vérifier les tables
    check_tables_task = PythonOperator(
        task_id='check_tables_task',
        python_callable=check_tables_exist,
    )

    # Définir l'ordre des tâches
    # add_connection_task >> check_tables_task
