## **1. Installation d'Airflow**
Si tu utilises **Airflow avec Docker**, l’image `apache/airflow` contient déjà tout ce qu'il faut. Sinon, pour une installation locale, utilise **pip** :

```bash
pip install apache-airflow
```
Ou avec une version spécifique (Ex : Airflow 2.6.1) :
```bash
pip install "apache-airflow==2.6.1" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.6.1/constraints-$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")').txt"
```

---

## **2. Packages supplémentaires selon les besoins**
Airflow est modulaire. Voici les packages utiles selon ton exécution :

| Package | Utilité | Installation |
|---------|--------|-------------|
| `apache-airflow-providers-docker` | Exécuter des tâches dans Docker | `pip install apache-airflow-providers-docker` |
| `apache-airflow-providers-ssh` | Exécuter des tâches sur un serveur distant via SSH | `pip install apache-airflow-providers-ssh` |
| `apache-airflow-providers-postgres` | Connexion à PostgreSQL | `pip install apache-airflow-providers-postgres` |
| `apache-airflow-providers-mysql` | Connexion à MySQL | `pip install apache-airflow-providers-mysql` |

Vu que notre **job Talend** nécessite **Java**, alors nous devrons nous assurer que Java est installé dans le conteneur ou machine.

---

## **3. Vérification de l'installation**
Après l'installation, teste Airflow :
```bash
airflow version
```
Puis, initialise la base de données :
```bash
airflow db init
```
Enfin, démarre les services :
```bash
airflow webserver --port 8080 &
airflow scheduler &
```

Avec **Docker**, tout est déjà inclus dans l’image `apache/airflow`. Il suffit de lancer :
```bash
docker-compose up -d
```