# Dockerfile pour OSRM
Ce dépôt se base sur le projet https://github.com/DoFabien/Dockerfile-OSRM et propose une mise à jour
des scripts pour utiliser la version 5 de [osrm-backend](https://github.com/Project-OSRM/osrm-backend).

## Récupérer l'image
Vous pouvez obtenir l'image facilement à partir de Docker Hub :

```
docker pull 5ika/osrm-backend
```
ou reconstruire l'image à partir de ce dépôt :

```
git clone https://github.com/5ika/osrm-docker.git
cd osrm-docker
docker build -t 5ika/osrm-backend .
```

## Données de cartographie
Le container utilise un fichier `.osm` ou `.osm.pbf` à placer dans un dossier `data/` à la racine du projet.

Il est possible de récupérer ce fichier à partir du site http://download.geofabrik.de/;

## Paramètres
Les fichiers contenant les profils (car.lua, foot.lua,etc.) se trouvent dans /data/profiles/.

  > * -e PROFILE_LUA= profile_à_utiliser

  > * -e FILE_OSM = fichier osm.pbf ou osm à utiliser

  > * -e REFRESH = 1 => les données sont repréparées à partir des données de base. Sinon et si elles ont déjà été préparées, on repart sur ces dernières.

## Démarrage
Après avoir placé le fichier `switzerland.osm.pbf` dans le dossier `data/`.

```
docker run -d -p 5000:5000 -v $PWD/data:/data \
 --name=osrm_switzerland \
  -e PROFILE_LUA=car.lua  \
  -e FILE_OSM=switzerland.osm.pbf \
  -e REFRESH=0 5ika/osrm-backend
```
Pour accéder aux logs:
```
docker logs -f osrm_switzerland
```
