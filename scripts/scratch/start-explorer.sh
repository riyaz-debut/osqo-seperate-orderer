echo ""
echo ""
echo "======================================================"
echo "  GENERATING DOCKER COMPOSE FILE FOR EXPLORER"
echo "======================================================"
echo ""
echo ""

set -eo pipefail

export PORT=$(jq -r '.machines[] | select(.name == "explorer") | .port' ./config.json)


set -eo pipefail

echo " 
# SPDX-License-Identifier: Apache-2.0

version: \"2.1\"

volumes:
  expgdata:
  walletstorenew:

networks:
  mynetwork.com:
    name: osqo-methodbridge

services:

  explorerdb.mynetwork.com:
    image: hyperledger/explorer-db:latest
    container_name: explorerdb.mynetwork.com
    hostname: explorerdb.mynetwork.com
    environment:
      - DATABASE_DATABASE=fabricexplorer
      - DATABASE_USERNAME=hppoc
      - DATABASE_PASSWORD=password
    healthcheck:
      test: \"pg_isready -h localhost -p 5432 -q -U postgres\"
      interval: 30s
      timeout: 10s
      retries: 5
    volumes:
      - expgdata:/var/lib/postgresql/data
    networks:
      - mynetwork.com

  explorer.mynetwork.com:
    image: hyperledger/explorer:latest
    container_name: explorer.mynetwork.com
    hostname: explorer.mynetwork.com
    environment:
      - DATABASE_HOST=explorerdb.mynetwork.com
      - DATABASE_DATABASE=fabricexplorer
      - DATABASE_USERNAME=hppoc
      - DATABASE_PASSWD=password
      - LOG_LEVEL_APP=info
      - LOG_LEVEL_DB=info
      - LOG_LEVEL_CONSOLE=debug
      - LOG_CONSOLE_STDOUT=true
      - DISCOVERY_AS_LOCALHOST=false
      - PORT=8080
    volumes:
      - ./config.json:/opt/explorer/app/platform/fabric/config.json
      - ./connection-profile:/opt/explorer/app/platform/fabric/connection-profile
      - ../organizations:/tmp/crypto
      - walletstorenew:/opt/explorer/wallet
    ports:
      - ${PORT}:8080
    logging:
      driver: \"json-file\"
      options:
        max-size: \"1000m\"
        max-file: \"3\"
    depends_on:
      explorerdb.mynetwork.com:
        condition: service_healthy
    networks:
      - mynetwork.com
"> ${PWD}/explorer/docker-compose-explorer.yaml


echo ""
echo ""
echo "====================================================="
echo "  EXPLORER DOCKER COMPOSE FILE GENERATED SUCCESSFULLY"
echo "====================================================="
echo ""
echo ""


sleep 2

echo ""
echo ""
echo "======================================================"
echo "  GENERATING EXPLORER NETWORK JSON FILE FOR EXPLORER"
echo "======================================================"
echo ""
echo ""

set -eo pipefail

jq --arg username $(jq -r '.machines[] | select(.name == "explorer") | .user_name' ./config.json) '.client.adminCredential.id = $username' ${PWD}/explorer/connection-profile/test-network.json > ${PWD}/explorer/connection-profile/test-network-updated.json


set -eo pipefail

mv ${PWD}/explorer/connection-profile/test-network-updated.json ${PWD}/explorer/connection-profile/test-network.json


echo ""
echo ""
echo "====================================================="
echo "  EXPLORER NETWORK JSON FILE GENERATED SUCCESSFULLY"
echo "====================================================="
echo ""
echo ""




echo ""
echo ""
echo "============================================"
echo "  ADDING HOSTS ENTRIES"
echo "============================================"
echo ""
echo ""

sleep 2

set -eo pipefail

./set-peer-base.sh etc

sleep 2

echo ""
echo ""
echo "============================================"
echo "  HOSTS ENTRIES ADDED SUCCESSFULLY"
echo "============================================"
echo ""
echo ""


echo ""
echo ""
echo "============================================"
echo "  RUNNING EXPLORER "
echo "============================================"
echo ""
echo ""

sleep 2

./set-peer-base.sh etc

docker-compose -f ./explorer/docker-compose-explorer.yaml up -d

sleep 2

echo ""
echo ""
echo "============================================"
echo "  EXPLORER RUNNING SUCCESSFULLY"
echo "============================================"
echo ""
echo ""


