#!/bin/bash




. utils.sh



config=$(cat config.json)

#MACHINES IPs

    # export OSQO_IP=
    # export BCP_IP="127.0.0.1"
    # export ESP_IP="127.0.0.1"
    # export BROKER_IP="127.0.0.1"



#OSQO 

    #PEERS
    export OSQO_IP=$(echo $config| jq -r '.machines[] | select(.name == "osqo") | .ip')
    export PEER_1_OSQO=$(echo $config| jq -r '.machines[] | select(.name == "osqo") | .ports.peer0_port')
    export PEER_2_OSQO=$(echo $config| jq -r '.machines[] | select(.name == "osqo") | .ports.peer1_port')
    
 
    #ORDERERS
    export ORDERER_1_OSQO=$(echo $config| jq -r '.machines[] | select(.name == "osqo") | .ports.orderer_1_port')
    export ORDERER_1_OSQO="7050"


    #COUCHDB
    export COUCHDB_USER_OSQO_PEER1="$(echo $config| jq -r '.machines[] | select(.name == "osqo") | .couchDbCreds.couch_peer1.user_name')"
    export COUCHDB_PASSWORD_OSQO_PEER1="$(echo $config| jq -r '.machines[] | select(.name == "osqo") | .couchDbCreds.couch_peer1.password')"

    export COUCHDB_USER_OSQO_PEER2="$(echo $config| jq -r '.machines[] | select(.name == "osqo") | .couchDbCreds.couch_peer2.user_name')"
    export COUCHDB_PASSWORD_OSQO_PEER2="$(echo $config| jq -r '.machines[] | select(.name == "osqo") | .couchDbCreds.couch_peer2.password')"

    export COUCHDB_OSQO_PEER_1="5984"
    export COUCHDB_OSQO_PEER_2="6984"

 

#BCP

    #PEERS
    export BCP_IP=$(echo $config| jq -r '.machines[] | select(.name == "bcp") | .ip')
    export PEER_1_BCP=$(echo $config| jq -r '.machines[] | select(.name == "bcp") | .ports.peer0_port')
    export PEER_2_BCP=$(echo $config| jq -r '.machines[] | select(.name == "bcp") | .ports.peer1_port')
    
 
    #ORDERERS
    export ORDERER_1_BCP=$(echo $config| jq -r '.machines[] | select(.name == "bcp") | .ports.orderer_1_port')

    
    #COUCHDB 
    export COUCHDB_USER_BCP_PEER1="$(echo $config| jq -r '.machines[] | select(.name == "bcp") | .couchDbCreds.couch_peer1.user_name')"
    export COUCHDB_PASSWORD_BCP_PEER1="$(echo $config| jq -r '.machines[] | select(.name == "bcp") | .couchDbCreds.couch_peer1.password')"

    export COUCHDB_USER_BCP_PEER2="$(echo $config| jq -r '.machines[] | select(.name == "bcp") | .couchDbCreds.couch_peer2.user_name')"
    export COUCHDB_PASSWORD_BCP_PEER2="$(echo $config| jq -r '.machines[] | select(.name == "bcp") | .couchDbCreds.couch_peer2.password')"

    export COUCHDB_BCP_PEER_1="7984"
    export COUCHDB_BCP_PEER_2="8984"



#ESP

    #PEERS
    export ESP_IP=$(echo $config| jq -r '.machines[] | select(.name == "esp") | .ip')
    export PEER_1_ESP=$(echo $config| jq -r '.machines[] | select(.name == "esp") | .ports.peer0_port')
    export PEER_2_ESP=$(echo $config| jq -r '.machines[] | select(.name == "esp") | .ports.peer1_port')
    
 
    #ORDERERS
    export ORDERER_1_ESP=$(echo $config| jq -r '.machines[] | select(.name == "esp") | .ports.orderer_1_port')


    #COUCHDB
    export COUCHDB_USER_ESP_PEER1="$(echo $config| jq -r '.machines[] | select(.name == "esp") | .couchDbCreds.couch_peer1.user_name')"
    export COUCHDB_PASSWORD_ESP_PEER1="$(echo $config| jq -r '.machines[] | select(.name == "esp") | .couchDbCreds.couch_peer1.password')"

    export COUCHDB_USER_ESP_PEER2="$(echo $config| jq -r '.machines[] | select(.name == "esp") | .couchDbCreds.couch_peer2.user_name')"
    export COUCHDB_PASSWORD_ESP_PEER2="$(echo $config| jq -r '.machines[] | select(.name == "esp") | .couchDbCreds.couch_peer2.password')"

    export COUCHDB_ESP_PEER_1="9984"
    export COUCHDB_ESP_PEER_2="10984"

  

#BROKER

    #PEERS

    export BROKER_IP=$(echo $config| jq -r '.machines[] | select(.name == "broker") | .ip')
    export PEER_1_BROKER=$(echo $config| jq -r '.machines[] | select(.name == "broker") | .ports.peer0_port')
    export PEER_2_BROKER=$(echo $config| jq -r '.machines[] | select(.name == "broker") | .ports.peer1_port')
    
 
    #ORDERERS
    export ORDERER_1_BROKER=$(echo $config| jq -r '.machines[] | select(.name == "broker") | .ports.orderer_1_port')


    #COUCHDB
    export COUCHDB_USER_BROKER_PEER1="$(echo $config| jq -r '.machines[] | select(.name == "broker") | .couchDbCreds.couch_peer1.user_name')"
    export COUCHDB_PASSWORD_BROKER_PEER1="$(echo $config| jq -r '.machines[] | select(.name == "broker") | .couchDbCreds.couch_peer1.password')"

    export COUCHDB_USER_BROKER_PEER2="$(echo $config| jq -r '.machines[] | select(.name == "broker") | .couchDbCreds.couch_peer2.user_name')"
    export COUCHDB_PASSWORD_BROKER_PEER2="$(echo $config| jq -r '.machines[] | select(.name == "broker") | .couchDbCreds.couch_peer2.password')"

    export COUCHDB_BROKER_PEER_1="11984"
    export COUCHDB_BROKER_PEER_2="12984"









 
