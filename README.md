
# Azuriom Docker Deployment

Ce projet permet de déployer le CMS [Azuriom](https://azuriom.com/) en utilisant Docker, Docker Compose et Helm pour une installation facile et modulable. La configuration inclut Nginx, PHP 8.3, MySQL, et d'autres dépendances pour supporter Azuriom.

## Contenu du projet

- **Dockerfile** : Configure l'image Docker pour Azuriom avec PHP, Nginx et les extensions nécessaires.
- **docker-compose.yml** : Définit les services, réseaux et volumes nécessaires pour exécuter Azuriom et MySQL.
- **chart Helm** (optionnel) : Facilite le déploiement sur un cluster Kubernetes.
- **.env.temp** : Modèle de fichier d'environnement pour définir les variables d'environnement.
- **entrypoint.sh** : Script d'initialisation qui configure le CMS et exécute les migrations.

## Prérequis

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- (Optionnel) [Helm](https://helm.sh/docs/intro/install/) pour le déploiement Kubernetes

## Installation

### 1. Clonez le dépôt

```bash
git clone https://github.com/idotek/azuriom-image.git
cd azuriom-image
```


### 2. Configurez les variables d'environnement

Modifier les variables d'environnement dans le fichier docker-compose à votre guise.
Variables d'environnement supportées:

| Variable                        | Description                                                                                         | Optionnel   |
|---------------------------------|-----------------------------------------------------------------------------------------------------|-------------|
| `WEB_DOMAIN`                    | URL de votre site internet                                                                          | Non         |
| `TLS_ENABLED`                   | Activez ou non le support TLS                                                                       | Oui         |
| `TLS_CERTIFICATE_FULLCHAIN_NAME`| Nom du fichier de votre certificat fullchain                                                        | Oui         |
| `TLS_CERTIFICATE_PRIVKEY_NAME`  | Nom du fichier de votre private key                                                                 | Oui         |
| `ADMIN_USERNAME`                | Nom d'utilisateur du compte admin                                                                   | Non         |
| `ADMIN_EMAIL`                   | Adresse email du compte admin                                                                       | Non         |
| `APP_NAME`                      | Nom de l'application                                                                               | Non         |
| `APP_ENV`                       | Environnement de l'application (ex: `local`, `production`)                                         | Non         |
| `APP_KEY`                       | Clé de l'application, utilisée pour le chiffrement                                                  | Automatique |
| `APP_DEBUG`                     | Mode debug (`true` ou `false`)                                                                      | Oui         |
| `APP_TIMEZONE`                  | Fuseau horaire de l'application                                                                    | Oui         |
| `APP_URL`                       | URL de base de l'application                                                                       | Oui         |
| `APP_LOCALE`                    | Langue par défaut de l'application                                                                 | Oui         |
| `APP_MAINTENANCE_DRIVER`        | Driver pour le mode maintenance                                                                    | Oui         |
| `AZURIOM_GAME`                  | Type de jeu configuré pour Azuriom                                                                 | Oui         |
| `BCRYPT_ROUNDS`                 | Nombre de rounds pour l'algorithme de hashage Bcrypt                                               | Oui         |
| `LOG_CHANNEL`                   | Canal pour la journalisation des logs                                                              | Oui         |
| `LOG_STACK`                     | Indicateur de pile pour les logs                                                                   | Oui         |
| `LOG_DEPRECATIONS_CHANNEL`      | Canal pour les dépréciations                                                                       | Oui         |
| `LOG_LEVEL`                     | Niveau de log (`debug`, `info`, `warning`, etc.)                                                   | Oui         |
| `DB_CONNECTION`                 | Type de connexion à la base de données (ex: `mysql`, `pgsql`)                                      | Non         |
| `DB_HOST`                       | Adresse de l'hôte de la base de données                                                            | Non         |
| `DB_PORT`                       | Port de la base de données                                                                         | Oui         |
| `DB_DATABASE`                   | Nom de la base de données                                                                          | Non         |
| `DB_USERNAME`                   | Nom d'utilisateur de la base de données                                                           | Non         |
| `DB_PASSWORD`                   | Mot de passe de la base de données                                                                 | Non         |
| `SESSION_DRIVER`                | Driver de session (ex: `file`, `cookie`, `database`)                                               | Oui         |
| `SESSION_LIFETIME`              | Durée de vie de la session en minutes                                                              | Oui         |
| `SESSION_ENCRYPT`               | Active ou désactive le chiffrement des sessions (`true` ou `false`)                                | Oui         |
| `SESSION_PATH`                  | Chemin pour les sessions                                                                          | Oui         |
| `SESSION_DOMAIN`                | Domaine des sessions                                                                              | Oui         |
| `BROADCAST_CONNECTION`          | Connexion de diffusion (`null` ou `redis`)                                                        | Oui         |
| `FILESYSTEM_DISK`               | Driver de stockage par défaut (`local`, `s3`, etc.)                                               | Oui         |
| `QUEUE_CONNECTION`              | Connexion pour la file d'attente (`sync`, `database`, etc.)                                       | Oui         |
| `CACHE_DRIVER`                  | Driver de cache (`file`, `redis`, etc.)                                                           | Oui         |
| `CACHE_PREFIX`                  | Préfixe pour le cache                                                                             | Oui         |
| `MEMCACHED_HOST`                | Hôte pour le cache Memcached                                                                      | Oui         |
| `REDIS_CLIENT`                  | Type de client Redis (`predis`, `phpredis`)                                                       | Oui         |
| `REDIS_HOST`                    | Adresse de l'hôte Redis                                                                           | Oui         |
| `REDIS_PASSWORD`                | Mot de passe pour Redis                                                                           | Oui         |
| `REDIS_PORT`                    | Port de Redis                                                                                     | Oui         |
| `MAIL_MAILER`                   | Service d'envoi d'email (`smtp`, `sendmail`)                                                      | Oui         |
| `MAIL_HOST`                     | Hôte SMTP pour les emails                                                                        | Oui         |
| `MAIL_PORT`                     | Port SMTP                                                                                        | Oui         |
| `MAIL_USERNAME`                 | Nom d'utilisateur pour le serveur SMTP                                                           | Oui         |
| `MAIL_PASSWORD`                 | Mot de passe SMTP                                                                                | Oui         |
| `MAIL_ENCRYPTION`               | Type de chiffrement pour les emails (`tls`, `ssl`)                                               | Oui         |
| `MAIL_FROM_ADDRESS`             | Adresse email de l'expéditeur par défaut                                                          | Oui         |
| `MAIL_FROM_NAME`                | Nom de l'expéditeur par défaut                                                                    | Oui         |
| `STEAM_KEY`                     | Clé API pour l'intégration Steam                                                                  | Oui         |
| `EPIC_CLIENT_ID`                | ID client pour l'API Epic Games                                                                   | Oui         |
| `EPIC_CLIENT_SECRET`            | Secret client pour l'API Epic Games                                                               | Oui         |
| `AWS_ACCESS_KEY_ID`             | Clé d'accès AWS                                                                                   | Oui         |
| `AWS_SECRET_ACCESS_KEY`         | Clé secrète AWS                                                                                   | Oui         |
| `AWS_DEFAULT_REGION`            | Région par défaut pour les services AWS                                                           | Oui         |
| `AWS_BUCKET`                    | Nom du bucket AWS S3                                                                             | Oui         |
| `AWS_USE_PATH_STYLE_ENDPOINT`   | Définit l'utilisation d'un endpoint de style chemin pour AWS (`true` ou `false`)                 | Oui         |



### 3. Construisez et démarrez les conteneurs

```bash
docker-compose up -d
```

Le service Azuriom sera accessible sur `http://localhost:80`, sauf configuration personnalisée.

### 4. Récuperation du mot de passe admin

Azuriom à besoin de quelques minutes avant d'etre ready, vous pouvez suivre l'evolution de l'installation avec la commande:

```bash
docker compose logs -f 
```

Pour recuperer le mot de passe admin:

```bash
docker compose logs |grep "Password:"
```

## Structure des fichiers



- `Dockerfile` : Installe PHP 8.3, Nginx, et les extensions PHP nécessaires pour Azuriom, ainsi que Composer et Node.js pour la gestion des dépendances.
- `docker-compose.yml` : Contient la configuration Docker Compose pour Azuriom et MySQL.
- `.env.temp` : Contient les variables d'environnement essentielles au fonctionnement d'Azuriom.
- `entrypoint.sh` : Effectue la configuration initiale d'Azuriom, installe les dépendances, et exécute les migrations de base de données.

## Utilisation

### Accéder à Azuriom

Une fois le conteneur démarré, vous pouvez accéder à Azuriom à l'adresse définie dans `WEB_DOMAIN` (par défaut, `http://localhost`).

### Commandes Docker Compose courantes

- Démarrer les conteneurs en mode détaché :
  ```bash
  docker-compose up -d
  ```

- Arrêter les conteneurs :
  ```bash
  docker-compose down
  ```

- Voir les logs des conteneurs :
  ```bash
  docker-compose logs
  ```

## Configuration TLS

Pour activer le TLS, mettez à jour les variables `TLS_ENABLED`, `TLS_CERTIFICATE_FULLCHAIN_NAME`, et `TLS_CERTIFIATE_PRIVKEY_NAME` dans `docker-compose.yml`. Le script `entrypoint.sh` configurera automatiquement les certificats pour Nginx.

## Personnalisation

### Installer des plugins et thèmes

Vous pouvez ajouter des thèmes et plugins en les copiant dans les répertoires appropriés du volume `azuriom_data`. Assurez-vous de redémarrer le conteneur pour appliquer les modifications.

### Mise à jour d'Azuriom

Pour mettre à jour Azuriom, entrez dans le conteneur et exécutez les commandes de mise à jour standard :

```bash
docker-compose exec azuriom bash
composer update
php artisan migrate
```

## 📋 Todo List

| Tâche                      | Statut           | Description                                  |
|----------------------------|------------------|----------------------------------------------|
| 🔒 Sécurité dans le Docker  | ❌ Non commencé  | Mettre en place des bonnes pratiques de sécurité pour Docker. |
| 📦 Helm Charts              | ⏳ En cours      | Création et configuration de Helm Charts.    |
| 📚 Tutoriel                 | ❌ Non commencé  | Écrire un tutoriel détaillé.                  |
| 💡 Exemple                  | ❌ Non commencé  | Créer un exemple pratique d'utilisation.     |

## Aide

Pour des questions ou problèmes, consultez la [documentation officielle d'Azuriom](https://azuriom.com/docs) ou créez une issue sur ce dépôt.

## Licence

Ce projet est sous licence Apache. Veuillez consulter le fichier `LICENSE` pour plus d'informations.
