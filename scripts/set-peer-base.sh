#!/bin/bash


. utils.sh

echo "inside set peer base file"

if [[ $# -lt 1 ]] ; then
  warnln "Please provide machine name"
  exit 0
fi

# importing automate-Ip file
. set-automate-configuration.sh


#PEERS

PEER0_OSQO=peer0.osqo.osqo.com
PEER1_OSQO=peer1.osqo.osqo.com

PEER0_OSQO_IP=${OSQO_IP}
PEER1_OSQO_IP=${OSQO_IP}


PEER0_BCP=peer0.bcp.osqo.com
PEER1_BCP=peer1.bcp.osqo.com

PEER0_BCP_IP=${BCP_IP}
PEER1_BCP_IP=${BCP_IP}


PEER0_ESP_IP=${ESP_IP}
PEER1_ESP_IP=${ESP_IP}


PEER0_ESP=peer0.esp.osqo.com
PEER1_ESP=peer1.esp.osqo.com

PEER0_BROKER_IP=${BROKER_IP}
PEER1_BROKER_IP=${BROKER_IP}


PEER0_BROKER=peer0.broker.osqo.com
PEER1_BROKER=peer1.broker.osqo.com




#ORDERERS

ORDERER_OSQO_IP=${OSQO_IP}
ORDERER_BCP_IP=${BCP_IP}
ORDERER_ESP_IP=${ESP_IP}
ORDERER_BROKER_IP=${BROKER_IP}


LOCALHOST_IP=127.0.0.1


ORDERER_OSQO=orderer0.osqo.osqo.com
ORDERER_BCP=orderer0.bcp.osqo.com
ORDERER_BROKER=orderer0.broker.osqo.com
ORDERER_ESP=orderer0.esp.osqo.com





if [[ $1 = "hlf" ]] ; then
  export MACHINE="hlf"
  export EXTRA_HOSTS="
      - ${PEER0_OSQO}:${OSQO_IP}    
      - ${PEER1_OSQO}:${OSQO_IP}  
      - ${ORDERER_OSQO}:${OSQO_IP}  
      - ${PEER0_BCP}:${BCP_IP}    
      - ${PEER1_BCP}:${BCP_IP}  
      - ${ORDERER_BCP}:${BCP_IP}   
      - ${PEER0_ESP}:${ESP_IP}    
      - ${PEER1_ESP}:${ESP_IP}  
      - ${ORDERER_ESP}:${ESP_IP}     
      - ${PEER0_BROKER}:${BROKER_IP}         
      - ${PEER1_BROKER}:${BROKER_IP} 
      - ${ORDERER_BROKER}:${BROKER_IP}              
  "


echo "**********************************************************"
echo "        GENERATING ETC/HOSTS"
echo "**********************************************************"

sudo /bin/sh -c 'echo "
'${PEER0_OSQO_IP}' '${PEER0_OSQO}'
'${PEER1_OSQO_IP}' '${PEER1_OSQO}'
'${ORDERER_OSQO_IP}' '${ORDERER_OSQO}' 
'${PEER0_BCP_IP}' '${PEER0_BCP}'
'${PEER1_BCP_IP}' '${PEER1_BCP}'
'${ORDERER_BCP_IP}' '${ORDERER_BCP}'
'${PEER0_BROKER_IP}' '${PEER0_BROKER}'
'${PEER1_BROKER_IP}' '${PEER1_BROKER}'
'${ORDERER_BROKER_IP}' '${ORDERER_BROKER}'
'${PEER0_ESP_IP}' '${PEER0_ESP}'
'${PEER1_ESP_IP}' '${PEER1_ESP}'
'${ORDERER_ESP_IP}' '${ORDERER_ESP}'
" >> /etc/hosts' 
fi



if [[ $1 = "etc" ]] ; then
  


echo "**********************************************************"
echo "        GENERATING ETC/HOSTS for machine"
echo "**********************************************************"

sudo /bin/sh -c 'echo "
'${PEER0_OSQO_IP}' '${PEER0_OSQO}'
'${PEER1_OSQO_IP}' '${PEER1_OSQO}'
'${ORDERER_OSQO_IP}' '${ORDERER_OSQO}' 
'${PEER0_BCP_IP}' '${PEER0_BCP}'
'${PEER1_BCP_IP}' '${PEER1_BCP}'
'${ORDERER_BCP_IP}' '${ORDERER_BCP}'
'${PEER0_BROKER_IP}' '${PEER0_BROKER}'
'${PEER1_BROKER_IP}' '${PEER1_BROKER}'
'${ORDERER_BROKER_IP}' '${ORDERER_BROKER}'
'${PEER0_ESP_IP}' '${PEER0_ESP}'
'${PEER1_ESP_IP}' '${PEER1_ESP}'
'${ORDERER_ESP_IP}' '${ORDERER_ESP}'
" >> /etc/hosts' 
fi



if [[ $1 = "hlf2" ]] ; then
  export MACHINE="HLF 2"
  export EXTRA_HOSTS="- ${PEER0_OSQO}:${PEER0_OSQO_IP}  #HLF 1 instance
      - ${PEER1_OSQO}:${PEER1_OSQO_IP}  #HLF 1 instance 
      - ${ORDERER_OSQO}:${ORDERER_OSQO_IP} #HLF 1 instance
      - ${PEER0_ESP}:${PEER0_ESP_IP}    #HLF 3 instance        
      - ${PEER1_ESP}:${PEER1_ESP_IP}   #HLF 3 instance           
      - ${ORDERER_ESP}:${PEER0_ESP_IP} #HLF 3 instance
      - ${PEER0_BROKER}:${PEER0_BROKER_IP}    #HLF 4 instance        
      - ${PEER1_BROKER}:${PEER1_BROKER_IP}   #HLF 4 instance
      - ${ORDERER_BROKER}:${PEER0_BROKER_IP} #HLF 4 instance    
  "

sudo /bin/sh -c 'echo "
'${PEER0_OSQO_IP}' '${PEER0_OSQO}'
'${PEER1_OSQO_IP}' '${PEER1_OSQO}'
'${ORDERER_OSQO_IP}' '${ORDERER_OSQO}' 
'${LOCALHOST_IP}' '${PEER0_BCP}'
'${LOCALHOST_IP}' '${PEER1_BCP}'
'${LOCALHOST_IP}' '${ORDERER_BCP}'
'${PEER0_BROKER_IP}' '${PEER0_BROKER}'
'${PEER1_BROKER_IP}' '${PEER1_BROKER}'
'${ORDERER_BROKER_IP}' '${ORDERER_BROKER}'
'${PEER0_ESP_IP}' '${PEER0_ESP}'
'${PEER1_ESP_IP}' '${PEER1_ESP}'
'${ORDERER_ESP_IP}' '${ORDERER_ESP}' 
" >> /etc/hosts'
fi


# FOR HLF 3

if [[ $1 = "hlf3" ]] ; then
  export MACHINE="HLF 3"
  export EXTRA_HOSTS="- ${PEER0_OSQO}:${PEER0_OSQO_IP}  #HLF 1 instance
      - ${PEER1_OSQO}:${PEER1_OSQO_IP}  #HLF 1 instance
      - ${ORDERER_OSQO}:${ORDERER_OSQO_IP} #HLF 1 instance   
      - ${PEER0_BCP}:${PEER0_BCP_IP}    #HLF 2  instance        
      - ${PEER1_BCP}:${PEER1_BCP_IP}   #HLF 2 instance
      - ${ORDERER_BCP}:${PEER0_BCP_IP} #HLF 2 instance
      - ${PEER0_BROKER}:${PEER0_BROKER_IP} #HLF 3 instance        
      - ${PEER1_BROKER}:${PEER1_BROKER_IP} #HLF 3 instance       
      - ${ORDERER_BROKER}:${ORDERER_BROKER_IP} #HLF 3 instance    
  "

sudo /bin/sh -c 'echo "
'${PEER0_OSQO_IP}' '${PEER0_OSQO}'
'${PEER1_OSQO_IP}' '${PEER1_OSQO}'
'${ORDERER_OSQO_IP}' '${ORDERER_OSQO}' 
'${PEER0_BCP_IP}' '${PEER0_BCP}'
'${PEER1_BCP_IP}' '${PEER1_BCP}'
'${ORDERER_BCP_IP}' '${ORDERER_BCP}'
'${PEER0_BROKER_IP}' '${PEER0_BROKER}'
'${PEER1_BROKER_IP}' '${PEER1_BROKER}'
'${ORDERER_BROKER_IP}' '${ORDERER_BROKER}'
'${LOCALHOST_IP}' '${PEER0_ESP}'
'${LOCALHOST_IP}' '${PEER1_ESP}'
'${LOCALHOST_IP}' '${ORDERER_ESP}' 
" >> /etc/hosts'
fi
 


# FOR HLF 4

if [[ $1 = "hlf4" ]] ; then
  export MACHINE="HLF 4"
  export EXTRA_HOSTS="- ${PEER0_OSQO}:${PEER0_OSQO_IP}  #HLF 1 instance
      - ${PEER1_OSQO}:${PEER1_OSQO_IP}  #HLF 1 instance
      - ${ORDERER_OSQO}:${ORDERER_OSQO_IP} #HLF 1 instance   
      - ${PEER0_BCP}:${PEER0_BCP_IP}    #HLF 2  instance        
      - ${PEER1_BCP}:${PEER1_BCP_IP}   #HLF 2 instance
      - ${ORDERER_BCP}:${PEER0_BCP_IP} #HLF 2 instance
      - ${PEER0_ESP}:${PEER0_ESP_IP} #HLF 4 instance        
      - ${PEER1_ESP}:${PEER1_ESP_IP} #HLF 4 instance       
      - ${ORDERER_ESP}:${ORDERER_ESP_IP} #HLF 4 instance    
  "

sudo /bin/sh -c 'echo "
'${PEER0_OSQO_IP}' '${PEER0_OSQO}'
'${PEER1_OSQO_IP}' '${PEER1_OSQO}'
'${ORDERER_OSQO_IP}' '${ORDERER_OSQO}' 
'${PEER0_BCP_IP}' '${PEER0_BCP}'
'${PEER1_BCP_IP}' '${PEER1_BCP}'
'${ORDERER_BCP_IP}' '${ORDERER_BCP}'
'${LOCALHOST_IP}' '${PEER0_BROKER}'
'${LOCALHOST_IP}' '${PEER1_BROKER}'
'${LOCALHOST_IP}' '${ORDERER_BROKER}'
'${PEER0_ESP_IP}' '${PEER0_ESP}'
'${PEER1_ESP_IP}' '${PEER1_ESP}'
'${ORDERER_ESP_IP}' '${ORDERER_ESP}' 
" >> /etc/hosts'
fi



