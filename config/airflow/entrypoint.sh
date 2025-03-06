#!/bin/bash

apt-get update -y && apt-get install -y default-jdk
pip install --no-cache-dir -r /opt/airflow/requirements.txt
pip install --upgrade azure

# shellcheck disable=SC2093
exec "$@"

echo "🔍 Vérification des scripts disponibles dans /entrypoint.d/"
ls -l /entrypoint.d/

# Rendre tous les scripts exécutables
#chmod +x /entrypoint.d/*.sh

# Exécuter chaque script dans l'ordre
for script in /entrypoint.d/*; do
    if [ -f "$script" ]; then
        echo "Exécution de $script ..."
        bash "$script"
    fi
done

echo "✅ Tous les scripts ont été exécutés !"
