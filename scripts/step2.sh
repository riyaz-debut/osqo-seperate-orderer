#!/bin/bash

. utils.sh

if [[ $# -lt 1 ]] ; then
  warnln "Please provide organization name"
  exit 0
fi

ORG_NAME=$1


if [ ! -f "../channel-artifacts/osqo-channel.tx" ] || [ ! -f "../organizations/peerOrganizations/osqo.osqo.com/connection-osqo.json" ] || [ ! -f "../system-genesis-file/genesis.block" ]; 
then

echo""
echo""
echo "============================================================"
echo "UNZIPPING CERTIFICATES,GENESIS AND OTHER FILES"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./unzip-certificate-data.sh

sleep 2

echo""
echo""
echo "============================================================"
echo "UNZIPPING DONE"
echo "============================================================"
echo""
echo""

sleep 2

echo""
echo""
echo "============================================================"
echo "ADDING HOSTS ENTRIES"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./set-peer-base.sh etc

sleep 2

echo""
echo""
echo "============================================================"
echo "HOSTS ENTRIES ADDED"
echo "============================================================"
echo""
echo""

sleep 2

fi

echo""
echo""
echo "============================================================"
echo "STARTING NODES OF ORGANIZATION $1"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./start-org.sh $ORG_NAME

sleep 2

echo""
echo""
echo "============================================================"
echo "NODES OF ORGANIZATION $1 STARTED SUCCESSFULLY"
echo "============================================================"
echo""
echo""

sleep 5


