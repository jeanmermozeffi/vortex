from sqlalchemy import create_engine

DATA_SOURCE_CONN = "postgresql://Admin:Admin123@cic-data-source-postgres:5432/COM_INGESTION_DB"
DWH_CONN = "postgresql://Admin:Admin123@cic-data-source-postgres:5432/COM_INGESTION_DB"

def check_db_connection(conn_str):
    """ Vérifie la connexion à une base de données """
    try:
        engine = create_engine(conn_str)
        with engine.connect() as connection:
            connection.execute("SELECT 1")
        return True
    except Exception as e:
        print(f"Erreur de connexion: {e}")
        return False

def validate_connections():
    """ Vérifie les connexions aux deux bases et lève une exception en cas d'échec """
    if not check_db_connection(DATA_SOURCE_CONN):
        raise Exception("Connexion à la Data Source échouée")
    if not check_db_connection(DWH_CONN):
        raise Exception("Connexion au DWH échouée")
