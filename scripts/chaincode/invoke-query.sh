. envVar.sh



#file where IPS and ports are set
. set-automate-configuration.sh


if [[ $# -lt 1 ]] ; then
  warnln "PLease add org name parameter"
  exit 0
fi


CHANNEL_NAME="osqo-channel"
CC_NAME="osqo-chaincode"
#set org
ORG=$1

chaincodeInvoke() {
#    $2
    echo "============================================="
    echo "INVOKING CHAINCODE"
    echo "============================================="
    ARGS=$1    
    ORG=$2
    PEER=$3
    setOrgPeersGlobals $ORG $PEER

    peer chaincode invoke -o orderer.osqo.com:$ORDERER_1_OSQO --ordererTLSHostnameOverride orderer.osqo.com --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n ${CC_NAME} --peerAddresses peer0.osqo.osqo.com:$PEER_1_OSQO --tlsRootCertFiles $PEER0_OSQO_CA --peerAddresses peer0.bcp.osqo.com:$PEER_1_BCP --tlsRootCertFiles $PEER0_BCP_CA --peerAddresses peer0.esp.osqo.com:$PEER_1_ESP --tlsRootCertFiles $PEER0_ESP_CA --peerAddresses peer0.broker.osqo.com:$PEER_1_BROKER --tlsRootCertFiles $PEER0_BROKER_CA -c $1 >&../logs/invokeLogs.txt
    res=$?
    { set +x; } 2>/dev/null

    cat ../logs/invokeLogs.txt
}



chaincodeQuery() {
    
    ORG=$2
    PEER=$3
    setOrgPeersGlobals $ORG $PEER

    echo "============================================="
    echo "QUERY CHAINCODE"
    echo "============================================="
    peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c $1 >&../logs/queryChaincode.txt
    res=$?
    { set +x; } 2>/dev/null
    cat ../logs/queryChaincode.txt
}

chaincodeQuery '{"Args":["GetAllOsqoRecords"]}' $ORG 1

sleep 3

# add new entry
chaincodeInvoke '{"Args":["CreateAsset","test_kk","blue","6","methodbridge","900"]}' $ORG 1

sleep 5

# reading asset by id 
chaincodeQuery '{"Args":["ReadAsset","test_kk"]}' $ORG 1

sleep 3

chaincodeQuery '{"Args":["ReadAsset","asset1"]}' $ORG 1

# delete asset
chaincodeInvoke '{"Args":["DeleteAsset","asset1"]}' $ORG 1

sleep 5

# checking whether asset1 deleted 
chaincodeQuery '{"Args":["ReadAsset","asset1"]}' $ORG 1

chaincodeQuery '{"Args":["GetAllAssets"]}' $ORG 1
