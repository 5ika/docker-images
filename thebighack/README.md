Ce dépôt rassemble la configuration pour créer une image Docker en vue du [Big Hack](https://www.creageneve.com/evenement/the-big-hack/) à Genève.

# Utilisation
Une image déjà construite est disponible sur [Docker Hub](https://hub.docker.com/r/5ika/thebighack/). Vous pouvez l'utiliser comme ceci :

```bash
docker run -d -p 8080:80 -p 2222:22 -e USER_PASSWORD=<user-password> -v $PWD:/var/www/html 5ika/thebighack
```

- `-p 8080:80` : L'application sera accessible sur  le port `8080`
- `-e USER_PASSWORD=<user-password>` : Définie le mot de passe de l'utilisateur `bighack`. Par défaut, le mot de passe est `chatbot`.
- `-p 2222:22` : Le serveur SSH sera accessible sur le port 2222
- `-v $PWD:/var/www/html` : Le dossier courant sera servie par Apache dans le container.

Ainsi, on peut accéder à l'application avec l'adresse `http://localhost:8080` et se connecter par SSH avec la commande `ssh -p 2222 bighack@localhost` (utiliser le mot de passe définie avec USER_PASSWORD).

Il est également possible d'accéder aux fichiers à travers une connexion SFTP (FTP par SSH) en utilisant, par exemple, l'outil Filezilla. Il faut pour cela préciser l'URL `sftp://localhost` et le port `2222`.

## Utiliser une base de données

Il est possible de lier une base de données à notre application. Par exemple, pour un serveur MySQL :

```bash
docker run --name my-db -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql
docker run -d -p 8080:80 -p 2222:22 -e USER_PASSWORD=<user-password> -v --link my-db:db $PWD:/var/www/html 5ika/thebighack
```

Ainsi, avec PHP, il est possible de joindre la base de données à l'adresse `db` (plutôt que `localhost` comme dans la plupart des cas).

# Configuration

Si la configuration d'Apache et/ou du serveur SSH ne vous convient pas, il est possible de re-créer une image avec une configuration custom. Pour ce faire, cloner ce dépôt, modifer comme voulu puis reconstruire l'image:

```bash
git clone https://github.com/5ika/thebighack-docker && cd thebighack-docker
... # Modification des fichiers
docker build -t thebighack-docker .
```

