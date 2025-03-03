from diagrams import Diagram, Cluster, Edge
from diagrams.aws.storage import S3
from diagrams.onprem.database import PostgreSQL, MySQL
from diagrams.onprem.workflow import Airflow
from diagrams.onprem.analytics import Spark
from diagrams.onprem.queue import Kafka
from diagrams.elastic.saas import Elastic
from diagrams.elastic.observability import Logs
from diagrams.programming.language import Java
from diagrams.programming.framework import Angular
from diagrams.onprem.analytics import PowerBI
from diagrams.generic.storage import Storage
from diagrams.onprem.client import Users
from diagrams.aws.analytics import Glue
from diagrams.custom import Custom

DEBEZIUM_ICON = "/home/jeeff/PycharmProjects/Vortex/src/resources/debezium.png"

with Diagram("CIC BI Architecture", show=True):
    # 📌 Data Sources
    with Cluster("Data Sources"):
        db_sources = PostgreSQL("PostgreSQL")
        mysql_sources = MySQL("MySQL")
        excel_sources = Storage("Excel / CSV")
        saari_sources = Storage("SAARI")
        drive_sources = Storage("Google Drive")
        iot_sources = Storage("IoT Devices")

    # 📌 Change Data Capture (CDC) avec Debezium
    with Cluster("CDC & Kafka Integration"):
        with Cluster("Debezium Server"):
            debezium_mysql = Custom("Debezium \nMySQL", DEBEZIUM_ICON)
            debezium_postgres = Custom("Debezium \nPostgreSQL", DEBEZIUM_ICON)
        kafka_ingest = Kafka("Kafka (Streaming \n& Message Bus)")

    # 📌 Data Extraction & Ingestion
    with Cluster("ETL & Ingestion"):
        talend = Glue("Talend ETL")

    # 📌 Data Processing
    with Cluster("Processing & Aggregation"):
        spark_streaming = Spark("Spark Streaming")
        spark_batch = Spark("Spark Batch")

    # 📌 Workflow Orchestration (Avec Planification des Rapports)
    with Cluster("Orchestration & Reports"):
        airflow = Airflow("Apache Airflow")  # Orchestration des jobs + Planification des Rapports

    # 📌 Data Storage
    with Cluster("Storage"):
        datalake = S3("Data Lake")
        datawarehouse = PostgreSQL("Data Warehouse")

    # 📌 Kafka for Streaming Output
    with Cluster("Real-time Processing"):
        kafka_processed = Kafka("Kafka Processed Data")

    # 📌 Monitoring & Logging (Centralisation des Logs avec Logstash)
    with Cluster("Monitoring & Logging"):
        logstash = Logs("Log Collector")
        elk = Elastic("Elasticsearch \n& Kibana")

    # 📌 Backend & Frontend
    backend = Java("Java Backend")
    frontend = Angular("Angular Dashboard")

    # 📌 BI & Reporting
    with Cluster("Business Intelligence"):
        powerbi = PowerBI("BI & Reporting")
        airflow_reports = Airflow("Airflow Reports")

    # 📌 User Access
    users = Users("End Users")

    # 🌟 **Définition des styles de flèches**
    main_flow = Edge(color="blue", penwidth="3.0")  # Trait principal en bleu épais
    secondary_flow = Edge(style="dashed", color="black", penwidth="2")  # Trait secondaire en pointill

    # 📌 Connexions entre les composants

    # ✅ Debezium écoute PostgreSQL & MySQL, et envoie à Kafka
    db_sources >> secondary_flow >> debezium_postgres >> main_flow >> kafka_ingest
    mysql_sources >> secondary_flow >> debezium_mysql >> main_flow >> kafka_ingest

    # ✅ Talend extrait des données depuis les bases et les fichiers
    db_sources >> main_flow >> talend
    mysql_sources >> main_flow >> talend
    excel_sources >> secondary_flow >> talend
    saari_sources >> secondary_flow >> talend
    drive_sources >> secondary_flow >> talend
    iot_sources >> main_flow >>  kafka_ingest  # IoT envoie les données directement à Kafka

    # ✅ Talend alimente Spark & Data Warehouse
    talend >> main_flow >> spark_batch
    talend >> main_flow >> datawarehouse

    # ✅ Kafka alimente Spark Streaming
    kafka_ingest >> main_flow >> spark_streaming

    # ✅ Spark traite et envoie vers Data Lake / Data Warehouse / Backend
    spark_streaming >> main_flow >> datalake
    spark_batch >> main_flow  >> datalake
    spark_batch >> main_flow >> datawarehouse

    # ✅ Ajout de Kafka Processed Data pour le Backend
    spark_streaming >> main_flow >> kafka_processed
    kafka_processed >> main_flow >> backend

    # ✅ Airflow planifie l'exécution des jobs ETL et la génération de rapports
    airflow >> main_flow >> talend
    airflow >> main_flow >> spark_batch
    airflow >> main_flow >> airflow_reports  # Airflow planifie les rapports

    # ✅ Backend transmet aux dashboards et outils BI
    datalake >> main_flow >> backend
    datawarehouse >> main_flow >>  backend
    backend >> main_flow >> frontend
    backend >> main_flow >> powerbi

    frontend >> elk  # Les logs du frontend vont vers ELK

    # ✅ Tous les outils envoient leurs logs vers Logstash
    [kafka_ingest, spark_streaming, spark_batch, backend, airflow, talend, datawarehouse] >> secondary_flow >> logstash
    logstash >> main_flow >> elk  # Centralisation vers ELK

    frontend >> main_flow >> users
