#!/bin/bash

#echo "Accès à MinIO avec la clé : $MINIO_ACCESS_KEY"
#echo "Clé secrète MinIO : $MINIO_SECRET_ACCESS_KEY"

# Vérifie si Airflow est accessible
echo "🔍 Vérification d'Airflow..."
airflow db check || { echo "❌ Airflow n'est pas accessible. Assure-toi qu'il est bien démarré."; exit 1; }

# Ajoute la connexion MinIO pour les logs dans Airflow
echo "🚀 Ajout de la connexion MinIO dans Airflow..."
if ! airflow connections get minio_s3 > /dev/null 2>&1; then
    echo "Ajout de la connexion MinIO ..."
    airflow connections add minio_s3 \
        --conn-type S3 \
        --conn-extra '{
              "aws_access_key_id": "'"$MINIO_ACCESS_KEY"'",
              "aws_secret_access_key": "'"$MINIO_SECRET_ACCESS_KEY"'",
              "endpoint_url": "http://cic-minio:9000",
              "region_name": "us-east-1"
          }'

else
    echo "Connexion MinIO déjà existante."
fi

if [ $? -eq 0 ]; then
    echo "✅ Connexion MinIO ajoutée avec succès !"
else
    echo "❌ Échec de l'ajout de la connexion MinIO."
fi

echo "✅ Configuration MinIO terminée !"
