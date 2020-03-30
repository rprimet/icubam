#!/usr/bin/env bash

# check that all required parameters are provided
if [ $# -ne 2 ]
then
	  echo "usage: $0 IMAGE_NAME PORT"
	  echo "   where IMAGE_NAME is the image name and tage to use"
	  echo "   where PORT is the local port number where to map the port of the server on the container"
      echo ""
      echo "   example: $0 icubam:1.0 9000"
	  exit
fi

echo '========================================='
echo 'Check the console to get the activation URL with docker logs'
echo 'Attention:'
echo '   replace the default port 8888 in the URL with the defined port'
echo '========================================='

docker run -dt -p 9000:8888 \
    --name icubam-sms \
    --mount type=bind,source="$(pwd)"/resources/icubam-docker.env,target=/home/icubam/resources/icubam.env \
    --mount type=bind,source="$(pwd)"/resources/icubam-docker.toml,target=/home/icubam/resources/icubam.toml \
    --mount type=bind,source="$(pwd)"/resources/icubam.db,target=/home/icubam/resources/icubam.db \
    --mount type=bind,source="$(pwd)"/resources/token.pickle,target=/home/icubam/resources/token.pickle \
    $1  \
    ./start_server_sms.sh