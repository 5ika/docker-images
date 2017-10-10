#!/bin/bash
DATA_PATH=${DATA_PATH:="/data"}

if [ ${FILE_OSM:(-8)} = ".osm.pbf" ]
then
echo ".osm.pbf!"
OSM_NAME=${FILE_OSM: 0:(-8)}

elif [ ${FILE_OSM:(-4)} = ".osm" ]
then
echo ".osm!"
OSM_NAME=${FILE_OSM: 0:(-4)}

else
 echo "osm.pbf OU osm uniquement"
fi

echo $OSM_NAME

mkdir -p /data/profiles
mv /src/profiles/*.lua /data/profiles/
rm -R /src

if [ -e /data/$OSM_NAME.osrm ] && [ $REFRESH != 1 ]
then
echo "rien"
else
./osrm-extract  /data/$FILE_OSM -p /data/profiles/$PROFILE_LUA

./osrm-contract  /data/$OSM_NAME.osrm

fi

./osrm-routed  /data/$OSM_NAME.osrm
