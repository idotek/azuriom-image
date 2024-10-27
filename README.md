
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
git clone https://github.com/votre-utilisateur/azuriom-docker-stack.git
cd azuriom-docker-stack.
```


### 2. Configurez les variables d'environnement

Modifier les variables d'environnement dans le fichier docker-compose à votre guise.
Variables d'environnement supportées:

| Variable                  | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| `APP_NAME`                | Nom de l'application.                                                      |
| `APP_ENV`                 | Environnement de l'application (ex: `local`, `production`).               |
| `APP_KEY`                 | Clé de l'application, utilisée pour le chiffrement.                        |
| `APP_DEBUG`               | Mode debug (`true` ou `false`).                                            |
| `APP_TIMEZONE`            | Fuseau horaire de l'application.                                           |
| `APP_URL`                 | URL de base de l'application.                                              |
| `APP_LOCALE`              | Langue par défaut de l'application.                                        |
| `APP_MAINTENANCE_DRIVER`  | Driver pour le mode maintenance.                                           |
| `AZURIOM_GAME`            | Type de jeu configuré pour Azuriom.                                        |
| `BCRYPT_ROUNDS`           | Nombre de rounds pour l'algorithme de hashage Bcrypt.                      |
| `LOG_CHANNEL`             | Canal pour la journalisation des logs.                                     |
| `LOG_STACK`               | Indicateur de pile pour les logs.                                          |
| `LOG_DEPRECATIONS_CHANNEL`| Canal pour les dépréciations.                                              |
| `LOG_LEVEL`               | Niveau de log (`debug`, `info`, `warning`, etc.).                          |
| `DB_CONNECTION`           | Type de connexion à la base de données (ex: `mysql`, `pgsql`).             |
| `DB_HOST`                 | Adresse de l'hôte de la base de données.                                   |
| `DB_PORT`                 | Port de la base de données.                                                |
| `DB_DATABASE`             | Nom de la base de données.                                                 |
| `DB_USERNAME`             | Nom d'utilisateur de la base de données.                                  |
| `DB_PASSWORD`             | Mot de passe de la base de données.                                        |
| `SESSION_DRIVER`          | Driver de session (ex: `file`, `cookie`, `database`).                     |
| `SESSION_LIFETIME`        | Durée de vie de la session en minutes.                                     |
| `SESSION_ENCRYPT`         | Active ou désactive le chiffrement des sessions (`true` ou `false`).       |
| `SESSION_PATH`            | Chemin pour les sessions.                                                  |
| `SESSION_DOMAIN`          | Domaine des sessions.                                                      |
| `BROADCAST_CONNECTION`    | Connexion de diffusion (`null` ou `redis`).                                |
| `FILESYSTEM_DISK`         | Driver de stockage par défaut (`local`, `s3`, etc.).                      |
| `QUEUE_CONNECTION`        | Connexion pour la file d'attente (`sync`, `database`, etc.).               |
| `CACHE_DRIVER`            | Driver de cache (`file`, `redis`, etc.).                                  |
| `CACHE_PREFIX`            | Préfixe pour le cache.                                                     |
| `MEMCACHED_HOST`          | Hôte pour le cache Memcached.                                              |
| `REDIS_CLIENT`            | Type de client Redis (`predis`, `phpredis`).                              |
| `REDIS_HOST`              | Adresse de l'hôte Redis.                                                   |
| `REDIS_PASSWORD`          | Mot de passe pour Redis.                                                   |
| `REDIS_PORT`              | Port de Redis.                                                             |
| `MAIL_MAILER`             | Service d'envoi d'email (`smtp`, `sendmail`).                             |
| `MAIL_HOST`               | Hôte SMTP pour les emails.                                                |
| `MAIL_PORT`               | Port SMTP.                                                                 |
| `MAIL_USERNAME`           | Nom d'utilisateur pour le serveur SMTP.                                   |
| `MAIL_PASSWORD`           | Mot de passe SMTP.                                                         |
| `MAIL_ENCRYPTION`         | Type de chiffrement pour les emails (`tls`, `ssl`).                       |
| `MAIL_FROM_ADDRESS`       | Adresse email de l'expéditeur par défaut.                                  |
| `MAIL_FROM_NAME`          | Nom de l'expéditeur par défaut.                                            |
| `STEAM_KEY`               | Clé API pour l'intégration Steam.                                          |
| `EPIC_CLIENT_ID`          | ID client pour l'API Epic Games.                                           |
| `EPIC_CLIENT_SECRET`      | Secret client pour l'API Epic Games.                                       |
| `AWS_ACCESS_KEY_ID`       | Clé d'accès AWS.                                                           |
| `AWS_SECRET_ACCESS_KEY`   | Clé secrète AWS.                                                           |
| `AWS_DEFAULT_REGION`      | Région par défaut pour les services AWS.                                   |
| `AWS_BUCKET`              | Nom du bucket AWS S3.                                                     |
| `AWS_USE_PATH_STYLE_ENDPOINT` | Définit l'utilisation d'un endpoint de style chemin pour AWS (`true` ou `false`). |




### 3. Construisez et démarrez les conteneurs

```bash
docker-compose up -d
```

Le service Azuriom sera accessible sur `http://localhost:80`, sauf configuration personnalisée.

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
