#!/bin/bash

. utils.sh

if [[ $# -lt 1 ]] ; then
  warnln "Please provide organization name"
  exit 0
fi


if [ ! -f "../channel-artifacts/osqo-channel.block" ]; 
then
echo""
echo""
echo "============================================================"
echo "UNZIPPING CHANNEL ARTIFACTS"
echo "============================================================"
echo""
echo""

sleep 2



unzip -o -d ../ ../channel-block.zip

sleep 2

echo""
echo""
echo "============================================================"
echo "UNZIPPING DONE"
echo "============================================================"
echo""
echo""

sleep 2

fi



echo""
echo""
echo "============================================================"
echo "JOINING CHANNEL FOR $1"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./scratch/join-channel-org.sh $1

sleep 2

echo""
echo""
echo "============================================================"
echo "CHANNEL JOINING FOR $1 DONE"
echo "============================================================"
echo""
echo""

sleep 2

exit


echo""
echo""
echo "============================================================"
echo "INSTALLING CHAINCODE ON $1"
echo "============================================================"

sleep 2

set -eo pipefail

./chaincode/install-chaincode.sh $1 osqo-chaincode /hlf-volume/hyperledger-chaincode/osqo-chaincode 1.0 1

sleep 2

echo""
echo""
echo "============================================================"
echo "CHAINCODE INSTALLATION FOR $1 DONE"
echo "============================================================"
echo""
echo""

sleep 2


if [[ $1 = "osqo" ]] ; then

echo""
echo""
echo "============================================================"
echo "COMMITING CHAINCODE"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./chaincode/commit-chaincode.sh osqo osqo-chaincode 1.0 1

echo""
echo""
echo "============================================================"
echo "CHAINCODE COMMITED"
echo "============================================================"
echo""
echo""

fi

