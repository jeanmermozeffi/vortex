from airflow import DAG
import sys
import os
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime, timedelta

from db_checks import validate_connections
from email_alerts import get_failure_email_operator

sys.path.append("/home/cicbi/vortex/src")

from talend.config.load_jobs import get_job_path

job_key = "jChargeDWH"
DAG_START_DATE = datetime(2024, 2, 26)

# Configuration du DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'start_date': DAG_START_DATE,  # Mettre une date antérieure
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'run_talend_job',
    default_args=default_args,
    description='DAG pour exécuter le job Talend à 2h du matin',
    schedule_interval='0 2 * * *',  # Tous les jours à 02:00
    catchup=False
)

# Vérification des connexions
check_connections = PythonOperator(
    task_id='check_connections',
    python_callable=validate_connections,
    dag=dag,
)

# Tâche pour exécuter le job Talend
run_talend_job = BashOperator(
    task_id=f"run_{job_key}",
    bash_command=get_job_path(job_key),
    dag=dag,
)

# Envoi d'un e-mail en cas d'échec
send_failure_email = get_failure_email_operator(dag)

check_connections

# Définition de l'ordre des tâches
check_connections >> run_talend_job
check_connections.on_failure_callback = lambda context: send_failure_email.execute(context)
