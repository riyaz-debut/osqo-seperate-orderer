#!/bin/bash

. envVar.sh

if [[ $# -lt 1 ]] ; then
  warnln "Invalid Command"
  exit 0
fi


if [[ $1 != "re-generate" ]] ; then
  warnln "Invalid Command"
  exit 0
fi


OSQO="osqo"
BCP="bcp"
ESP="esp"
BROKER="broker"
ORDERER="orderer"


# certificate authorities compose file for BCP
COMPOSE_FILE_CA_BCP=../docker-compose-ca/bcp/compose/docker-compose-bcp-ca.yaml

# certificate authorities compose file for OSQO
COMPOSE_FILE_CA_OSQO=../docker-compose-ca/osqo/compose/docker-compose-osqo-ca.yaml


# certificate authorities compose file for ESP
COMPOSE_FILE_CA_ESP=../docker-compose-ca/esp/compose/docker-compose-esp-ca.yaml

# certificate authorities compose file for Broker
COMPOSE_FILE_CA_BROKER=../docker-compose-ca/broker/compose/docker-compose-broker-ca.yaml

# certificate authorities compose file for orderer
# COMPOSE_FILE_CA_ORDERER=../docker-compose-ca/orderer/compose/docker-compose-orderer-ca.yaml

function orgCaUp(){
  docker-compose -f $1 up -d 2>&1
}

orgCaUp $COMPOSE_FILE_CA_OSQO
orgCaUp $COMPOSE_FILE_CA_BCP
# orgCaUp $COMPOSE_FILE_CA_ORDERER
orgCaUp $COMPOSE_FILE_CA_ESP
orgCaUp $COMPOSE_FILE_CA_BROKER

export PATH=${HOME}/fabric-samples/bin:$PATH
export FABRIC_CFG_PATH=${PWD}/../configtx
export VERBOSE=false


# ================================ ORGANIZATIONS ==============================================


# ================================ ENROLLING CA ADMIN FOR ORGS =================================
function enrollOrgCaAdmin(){
    echo "=================================================="
    echo "ENROLL CA for "$1
    echo "=================================================="

    # rm -rf ${PWD}/../organizations/peerOrganizations/$1.osqo.com/
    mkdir -p ${PWD}/../organizations/peerOrganizations/$1.osqo.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/$1.osqo.com/


    set -x
    fabric-ca-client enroll -u https://admin:adminpw@localhost:$2 --caname ca-$1 --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
    { set +x; } 2>/dev/null

}

enrollOrgCaAdmin $OSQO 7054 
enrollOrgCaAdmin $BCP 8054
enrollOrgCaAdmin $ESP 9054
enrollOrgCaAdmin $BROKER 12054

# Writing config.yaml file for Orgs
echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-osqo.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-osqo.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-osqo.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-osqo.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/osqo.osqo.com/msp/config.yaml

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-bcp.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-bcp.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-bcp.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-bcp.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/bcp.osqo.com/msp/config.yaml

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-esp.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-esp.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-esp.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-esp.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/esp.osqo.com/msp/config.yaml

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-broker.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-broker.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-broker.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-broker.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/broker.osqo.com/msp/config.yaml



# ================================ REGISTER PEERS FOR ORGS =========================================

function RegisterPeers(){
  echo "=================================================="
  echo "Register peer0 for "$1
  echo "=================================================="

  export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/$1.osqo.com/

  set -x
  fabric-ca-client register --caname ca-$1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null

  echo "=================================================="
  echo "Register peer1 for "$1
  echo "=================================================="
  set -x
  fabric-ca-client register --caname ca-$1 --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null



  echo "=================================================="
  echo "Register orderer0 for "$1
  echo "=================================================="


   set -x
  fabric-ca-client register --caname ca-$1 --id.name orderer0 --id.secret orderer0pw --id.type orderer --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null
}

RegisterPeers $OSQO
RegisterPeers $BCP
RegisterPeers $ESP
RegisterPeers $BROKER


# ================================= REGISTER USERS FOR ORGS ==========================================

function RegisterUser(){
  echo "=================================================="
  echo "Register user for "$1
  echo "=================================================="

  export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/$1.osqo.com/

  set -x
  fabric-ca-client register --caname ca-$1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null

}

RegisterUser $OSQO
RegisterUser $BCP
RegisterUser $ESP
RegisterUser $BROKER


# ================================ REGISTER ADMIN FOR ORGS =============================================

function RegisterOrgAdmin(){
  echo "=================================================="
  echo "Register Admin for "$1
  echo "=================================================="

  export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/$1.osqo.com/

  set -x
  fabric-ca-client register --caname ca-$1 --id.name $1admin --id.secret $1adminpw --id.type admin --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null

}

RegisterOrgAdmin $OSQO
RegisterOrgAdmin $BCP
RegisterOrgAdmin $ESP
RegisterOrgAdmin $BROKER

# ================================ GENERATE MSP PEERS FOR ORGS =======================================

function GenerateMsp(){
  echo "=================================================="
  echo "Generate MSP for peer0 "$1
  echo "=================================================="

  export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/$1.osqo.com/

  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:$2 --caname ca-$1 -M ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/msp --csr.hosts peer0.$1.osqo.com --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/
  

  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/msp/config.yaml

  echo "=================================================="
  echo "Generate MSP for peer1 "$1
  echo "=================================================="

  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:$2 --caname ca-$1 -M ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/msp --csr.hosts peer1.$1.osqo.com --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/msp/config.yaml




  echo "=================================================="
  echo "Generate MSP for orderer0 "$1
  echo "=================================================="

  set -x
  fabric-ca-client enroll -u https://orderer0:orderer0pw@localhost:$2 --caname ca-$1 -M ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/msp --csr.hosts orderer0.$1.osqo.com --csr.hosts localhost --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null


  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/msp/config.yaml



  echo "=================================================="
  echo "Generate MSP for USER "$1
  echo "=================================================="

  # //adding tls-cert into users folder
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:$2 --caname ca-$1 -M ${PWD}/../organizations/peerOrganizations/$1.osqo.com/users/User1@$1.osqo.com/msp --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null

  # copying config.yaml into users msp folder
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/$1.osqo.com/users/User1@$1.osqo.com/msp/config.yaml


  echo "=================================================="
  echo "Generate MSP for ORG ADMIN "$1
  echo "=================================================="

  # adding tls-cert into admin folder
  set -x
  fabric-ca-client enroll -u https://$1admin:$1adminpw@localhost:$2 --caname ca-$1 -M ${PWD}/../organizations/peerOrganizations/$1.osqo.com/users/Admin@$1.osqo.com/msp --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null


  DIR="../../organizations/keystore-file/"
  if [ ! -d "$DIR" ]; then
    # Take action if $DIR not exists. #
    mkdir -p ../organizations/keystore-file
    println "storing keystore file"
    cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/users/Admin@$1.osqo.com/msp/keystore/* ${PWD}/../organizations/keystore-file/$1-key   
  else
    cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/users/Admin@$1.osqo.com/msp/keystore/* ${PWD}/../organizations/keystore-file/$1-key
    println "keystore file already saved"
  fi

  # copying config.yaml into admin msp folder
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/$1.osqo.com/users/Admin@$1.osqo.com/msp/config.yaml


}

GenerateMsp $OSQO 7054
GenerateMsp $BCP 8054
GenerateMsp $ESP 9054
GenerateMsp $BROKER 12054


# =============================== REGISTER TLS FOR PEERS =========================================

function GeneratePeerTLS(){
  echo "=================================================="
  echo "Generate TLS for peer0 "$1
  echo "=================================================="
  
  # creating tls
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:$2 --caname ca-$1 -M ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/tls --enrollment.profile tls --csr.hosts peer0.$1.osqo.com --csr.hosts localhost --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/tls/ca.crt
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/tls/server.crt
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/tls/server.key


  mkdir -p ${PWD}/../organizations/peerOrganizations/$1.osqo.com/msp/tlscacerts
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/../organizations/peerOrganizations/$1.osqo.com/tlsca
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/tlsca/tlsca.$1.osqo.com-cert.pem

  mkdir -p ${PWD}/../organizations/peerOrganizations/$1.osqo.com/ca
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer0.$1.osqo.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/ca/ca.$1.osqo.com-cert.pem

  echo "=================================================="
  echo "Generate TLS for peer1 "$1
  echo "=================================================="

  # creating tls
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:$2 --caname ca-$1 -M ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/tls --enrollment.profile tls --csr.hosts peer1.$1.osqo.com --csr.hosts localhost --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null


  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/tls/ca.crt

  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/tls/server.crt

  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/tls/server.key



  mkdir -p ${PWD}/../organizations/peerOrganizations/$1.osqo.com/msp/tlscacerts

  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/../organizations/peerOrganizations/$1.osqo.com/tlsca
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/tlsca/tlsca.$1.osqo.com-cert.pem

  mkdir -p ${PWD}/../organizations/peerOrganizations/$1.osqo.com/ca
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/peer1.$1.osqo.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/ca/ca.$1.osqo.com-cert.pem





  echo "=================================================="
  echo "Generate orderer0 TLS for "$1
  echo "=================================================="


  set -x
  fabric-ca-client enroll -u https://orderer0:orderer0pw@localhost:$2 --caname ca-$1 -M ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/tls --enrollment.profile tls --csr.hosts orderer0.$1.osqo.com --csr.hosts localhost --tls.certfiles ${PWD}/../docker-compose-ca/$1/fabric-ca/tls-cert.pem
  { set +x; } 2>/dev/null


  
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/tls/ca.crt
  
  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/tls/server.crt

  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/tls/server.key

  mkdir -p ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/msp/tlscacerts

  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/msp/tlscacerts/tlsca.$1.osqo.com-cert.pem



  mkdir -p ${PWD}/../organizations/peerOrganizations/$1.osqo.com/ca

  cp ${PWD}/../organizations/peerOrganizations/$1.osqo.com/peers/orderer0.$1.osqo.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/$1.osqo.com/ca/ca.$1.osqo.com-cert.pem



}

GeneratePeerTLS $OSQO 7054
GeneratePeerTLS $BCP 8054
GeneratePeerTLS $ESP 9054
GeneratePeerTLS $BROKER 12054






