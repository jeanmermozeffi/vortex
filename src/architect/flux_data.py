#
# from diagrams.aws.analytics import Glue
# from diagrams import Diagram, Cluster
# from diagrams.aws.storage import S3
# from diagrams.onprem.database import PostgreSQL, MySQL
# from diagrams.onprem.workflow import Airflow
# from diagrams.onprem.analytics import Spark
# from diagrams.onprem.queue import Kafka
# from diagrams.elastic.saas import Elastic
# from diagrams.programming.language import Java
# from diagrams.programming.framework import Angular
# from diagrams.onprem.analytics import PowerBI, Tableau
# from diagrams.generic.storage import Storage
# from diagrams.onprem.client import Users
#
# with Diagram("CIC BI Architecture", show=True):
#
#     # Data Sources
#     with Cluster("Data Sources"):
#         db_sources = PostgreSQL("PostgreSQL")
#         mysql_sources = MySQL("MySQL")
#         excel_sources = Storage("Excel / CSV")
#         saari_sources = Storage("SAARI")
#         drive_sources = Storage("Google Drive")
#         iot_sources = Storage("IoT Devices")
#         api_sources = Storage("API Data")
#
#     # Data Extraction & Ingestion
#     with Cluster("ETL & Ingestion"):
#         talend = Glue("Talend ETL")
#         kafka = Kafka("Kafka / MQTT")
#
#     # Data Processing
#     with Cluster("Processing & Aggregation"):
#         spark_streaming = Spark("Spark Streaming")
#         spark_batch = Spark("Spark Batch")
#
#     # Workflow Orchestration
#     airflow = Airflow("Apache Airflow")
#
#     # Data Storage
#     with Cluster("Storage"):
#         datalake = S3("Data Lake")
#         datawarehouse = PostgreSQL("Data Warehouse")
#
#     # Monitoring & Logging
#     elk = Elastic("ELK Stack")
#
#     # Backend & Frontend
#     backend = Java("Java Backend")
#     frontend = Angular("Angular Dashboard")
#     powerbi = PowerBI("Power BI")
#     tableau = Tableau("Tableau")
#
#     # User Access
#     users = Users("End Users")
#
#     # Data Flow Connections
#     db_sources >> talend
#     mysql_sources >> talend
#     excel_sources >> talend
#     saari_sources >> talend
#     drive_sources >> talend
#     api_sources >> kafka
#     iot_sources >> kafka
#
#     talend >> spark_batch
#     kafka >> spark_streaming
#
#     spark_streaming >> datalake
#     spark_batch >> datalake
#     spark_batch >> datawarehouse
#
#     airflow >> talend
#     airflow >> spark_batch
#
#     datalake >> backend
#     datawarehouse >> backend
#
#     backend >> frontend
#     backend >> powerbi
#     backend >> tableau
#
#     elk >> backend
#     elk >> airflow
#
#     frontend >> users
#     powerbi >> users
#     tableau >> users