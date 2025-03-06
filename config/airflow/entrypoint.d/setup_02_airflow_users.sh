#!/bin/bash

# Attendre que la base de données soit prête
sleep 10

# Initialiser la base de données (si ce n'est pas déjà fait)
# airflow db migrate

# Vérifier si l'utilisateur admin existe déjà
USER_EXISTS=$(airflow users list | grep admin | wc -l)

# Créer un utilisateur admin si aucun utilisateur n'existe
if [ "$USER_EXISTS" -eq "0" ]; then
    echo "Création de l'utilisateur admin..."
    airflow users create \
        --username "admin" \
        --password "admin" \
        --firstname "Effi" \
        --lastname "Jean Mermoz" \
        --role "Admin" \
        --email "jeanmermozeffi@gmail.com"
else
    echo "L'utilisateur admin existe déjà."
fi

# Lancer le webserver
exec airflow webserver
