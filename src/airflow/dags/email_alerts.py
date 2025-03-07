from airflow.operators.email import EmailOperator

def get_failure_email_operator(dag):
    """ Retourne un opérateur d'envoi d'e-mail en cas d'échec """
    return EmailOperator(
        task_id='send_failure_email',
        to="jeanmermozeffi@gmail.com",
        subject="⚠️ Échec du job Talend",
        html_content="Le job Talend n'a pas pu être exécuté en raison d'un problème de connexion aux bases de données.",
        dag=dag,
    )
