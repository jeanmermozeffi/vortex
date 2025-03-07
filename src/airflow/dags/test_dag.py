from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator
from datetime import datetime

# Fonction simple pour tester
def simple_task():
    print("Airflow fonctionne correctement!")

# Définition du DAG
default_args = {
    'owner': 'airflow',
    'start_date': datetime(2025, 2, 27),
    'retries': 1,
}

dag = DAG(
    'test_airflow_dag',  # Nom du DAG
    default_args=default_args,
    description='Un test simple pour vérifier que Airflow fonctionne',
    schedule_interval=None,  # Ce DAG ne s'exécute pas automatiquement
)

# Définir les tâches
start_task = DummyOperator(
    task_id='start',
    dag=dag,
)

run_task = PythonOperator(
    task_id='simple_task',
    python_callable=simple_task,
    dag=dag,
)

# Dépendances
start_task >> run_task
