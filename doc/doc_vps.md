# Accès VPS et Commandes Utiles

## Accès aux serveurs VPS

| Nom du serveur | Adresse Privée | Adresse Publique (VPS) | Port SSH |
|:---------------|:----------------|:-----------------------|:--------|
| SRV-POSTGRESQL | 10.10.99.25      | 160.154.95.33           | 22023    |
| SRV-SPARK      | 10.10.99.26      | 160.154.95.33           | 22024    |
| SRV-KAFKA      | 10.10.99.27      | 160.154.95.33           | 22025    |

## Commandes de connexion SSH

```bash
# Connexion à SRV-AIRFLOW-TALEND
ssh -p 10033 user@160.155.224.98
```

```bash
# Connexion à SRV-POSTGRESQL
ssh -p 22023 user@160.154.95.33
```

```bash
# Connexion à SRV-SPARK
ssh -p 22024 user@160.154.95.33
```

```bash
# Connexion à SRV-KAFKA
ssh -p 22025 user@160.154.95.33
```
## Connexions SSH rapides

```bash
# SRV-AIRFLOW-TALEND
ssh -i ~/.ssh/id_cicbi_rsa -p 10033 user@160.155.224.98
```

```bash
# SRV-SPARK
ssh -i ~/.ssh/id_cicbi_rsa -p 22024 user@160.154.95.33
```

```bash
# SRV-KAFKA
ssh -i ~/.ssh/id_cicbi_rsa -p 22025 user@160.154.95.33
```

```bash
# SRV-CICBI
ssh -i ~/.ssh/id_cicbi_rsa -p 10033 cicbi@160.155.224.98
```

## Exemple de configuration SSH (~/.ssh/config)

```ssh
Host srv-airflow-talend
    HostName 160.155.224.98
    Port 10033
    User user
    IdentityFile ~/.ssh/your_private_key
    
Host srv-postgresql
    HostName 160.154.95.33
    Port 22023
    User user
    IdentityFile ~/.ssh/your_private_key

Host srv-spark
    HostName 160.154.95.33
    Port 22024
    User user
    IdentityFile ~/.ssh/your_private_key

Host srv-kafka
    HostName 160.154.95.33
    Port 22025
    User user
    IdentityFile ~/.ssh/your_private_key
```

## Copier une clé SSH sur un serveur

```bash
ssh-copy-id -i ~/.ssh/your_private_key -o Port=22023 user@160.154.95.33
ssh-copy-id -i ~/.ssh/your_private_key -o Port=22024 user@160.154.95.33
ssh-copy-id -i ~/.ssh/your_private_key -o Port=22025 user@160.154.95.33
ssh-copy-id -i ~/.ssh/your_private_key -o Port=10033 user@160.155.224.98
```

## Test de base : se connecter via SSH
```bash
ssh -i ~/.ssh/your_private_key -o Port=10033 user@160.155.224.98
```

## Connecter avec :
```bbash
ssh srv-airflow-talend
```
```bash
ssh srv-postgresql
```
```bah
ssh srv-spark
```
```bash
ssh srv-kafka
```

## Transferts de fichiers (SCP)

```bash
# Copier un fichier local vers SRV-POSTGRESQL
scp -P 22023 /chemin/vers/fichier user@160.154.95.33:/chemin/destination

# Copier un fichier depuis SRV-SPARK vers local
scp -P 22024 user@160.154.95.33:/chemin/du/fichier /chemin/local
```

## Commandes utiles

```bash
# Redémarrer un serveur
sudo reboot

# Vérifier l’état du disque
df -h

# Vérifier l’état de la mémoire
free -h

# Vérifier les services actifs
sudo systemctl status nom_du_service

# Mettre à jour le système
sudo apt update && sudo apt upgrade -y
```

## Création d'un nouvel utilisateur SSH

```bash
# 1. Créer l'utilisateur
sudo adduser username
```

```bash
# 2. Ajouter aux sudoers
sudo usermod -aG sudo username
```

```bash
# 3. Créer le dossier SSH et copier la clé
sudo mkdir -p /home/username/.ssh
sudo cp /home/user/.ssh/authorized_keys /home/username/.ssh/
```

```bash
# 4. Fixer les droits
sudo chown -R username:username /home/cicbi/.ssh
sudo chmod 700 /home/username/.ssh
sudo chmod 600 /home/username/.ssh/authorized_keys
```

## Notes supplémentaires
- Les adresses privées (10.10.99.x) sont accessibles uniquement entre les serveurs.
- Les connexions publiques passent toutes par l'adresse 160.154.95.33 avec des ports différents.
- Toujours utiliser la bonne clé SSH si elle est configurée.

```aiignore
jean.effi@synertech-ci.net 
```


