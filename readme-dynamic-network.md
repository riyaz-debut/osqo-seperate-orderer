
***Run following command one by one to setup the network***

  

Note :- Read the install-prereq.md file to install requirements before proceeding further

  




## CLONE THE REPO 
**Move to each and every machine one by one and clone the hyperledger and hyperledger sdk repo in additional volume of each machine named hlf-volume by using commands :- **

  

  

  

  

`cd /`

  

  

  

Note :- Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.

  
  

`cd hlf-volume`

  

  

  

  

  

*** Clone the hyperledger repo for network configuration on each machine (except sdk and explorer machine):-

  

`git clone https://tejindermethodbridge@bitbucket.org/osqo/hyperledger.git`




*** Clone the hyperledger-sdk repo on each machine (except sdk and explorer machine) for chaincode :-
`git clone https://tejindermethodbridge@bitbucket.org/osqo/hyperledger-sdk.git`

  
Change branch of hyperledger on **every machine** (except sdk and explorer machine)using commands :- 

Note :- Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.

`cd hyperledger`


`git checkout dynamic-network`

  

  

  
## CERTIFICATE GENERATION SECTION


**Open machine (lets say HLF 1) where you want to generate certificates for all orgs**

  

  

  

  

  

  

***In that HLF 1 machine***

  

  



  

  

  

**Move to additional volume named hlf-volume by using commands :- **

  

  

  

  

`cd /`

  

  

  

Note :- Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.

  
  

`cd hlf-volume`

  

  

  

  

  


  

  

  

****Inside HLF 1 machine go to***

  

  

  

  

  

  

  

>  **/hlf-volume/hyperledger folder**

  

  

  

  

  

  

  

using command

  

  

  

  

  

  

  

`cd hyperledger`

  

  

  

  




  

  

  

  

and then move to scripts folder with command :-**

  

  

  

  

  

  

  

`cd scripts`

  

  

  

  

  

  

  

***Note :- Now every command will be run from this scripts folder.***

  

  

  

  

  

  

  

## Fabric CA

  

  

  

  

  

  

***In same HLF 1 machine***

  

  

  

  

  

run

  

  

  

  

  

  

`./scratch/generate-msp.sh re-generate`

  

  

  

  

  

  

  

***(Note use this to re-generate network certs). This will clear the old certs.***

  

  

  

  

  

  

  

This will create fabric ca, register and enroll peers, users etc and created MSP, organizations folder will be created after running this command. (hlf-volume/hyperledger/organizations)

  

  

  

  

  ## GENERATE CONFIGS for all Machines

  

  

  

  

  

  

***In HLF 1 machine***

  

  

  

  

  

  

  

Update IP addresses for nodes and ports of OSQO, BCP, ESP, BROKER machines by replacing the old IP address entries with new IP addresses and old ports (if required) with new port numbers in **set-automate-configuration.sh** file in /hlf-volume/hyperledger/scripts/set-automate-configuration.sh file

  

  

  

  

  

  

  

**To generate config file for  machine nodes:-**

  

  

  

  

  

  

  

***OPEN*** set-automate-configuration.sh file located at

  

  

  

  

  

  

  

**

  

  

  

  

  

>  **/hlf-volume/hyperledger/scripts/set-automate-configuration.sh**

  

  

  

  

  

**

  

  

  

  

  

  

  

file in HLF 1 machine

  

  

  

  

  

  

  

*** Change the IP addresses for OSQO,BCP, ESP, BROKER organization .i.e. **OSQO, BCP, ESP and BROKER**

  

  

  

  
NOTE:- Make sure there are no old entries in /etc/hosts file of machine regarding organizations( OSQO,BCP,ESP and Broker) of our network.(in case using old instances)

Open the /etc/hosts file using command :- 

`sudo nano /etc/hosts`
  
If there are entries regarding old ip addresses of OSQO,BCP,ESP and Broker , delete them first.
  

  

**REPLACE** the followings in set-automate-configuration.sh file :-

  

  

  

  

  

  

  

- OSQO_IP={OSQO IP}

  

- BCP_IP={BCP IP}

  

  

  

  

  

  

- ESP_IP={ESP IP}

  

  

  

  

  

  

- BROKER_IP={BROKER IP}

  

  

  

  

  

  

  

  

  

  

where **{OSQO IP}, {BCP IP} , {ESP IP} , {BROKER IP} ** are the IP address of OSQO, BCP , ESP and BROKER

  

  

  

  

  

  

  

> e.g. if IP address of OSQO machine is **54.252.142.45** then

  

> OSQO_IP=54.252.142.45

  

> IP address of BCP machine is **3.27.44.202** then

  

> BCP_IP=3.27.44.202

  

> if IP address of ESP machine is **13.236.135.224** then

  

> ESP_IP=13.236.135.224

  

> if IP address of BROKER machine is **13.236.209.144** then

  

> BROKER_IP=13.236.209.144

  

**And then replace Port numbers (if required)**



Replace (if required) the following ports with your desired port numbers :-

#PEERS

- PEER_1_OSQO="7051"

- PEER_2_OSQO="6051"

#ORDERERS

- ORDERER_1_OSQO="7050"

  

#COUCHDB

  

- COUCHDB_OSQO_PEER_1="5984"

- COUCHDB_OSQO_PEER_2="6984"



 Note :- You can set ports for **BCP** as same as other organization ports (only if BCP is on different machine (different IP) than that organization)  in this file if **BCP** is going to deploy on different machine  e.g. if PEER_1_OSQO = 7051 then PEER_1_BCP =7051 also if and only if OSQO and BCP are on different machines from each other.(Same is for other ports)

For **BCP** replace (if required) the following ports with your desired port numbers :-

#PEERS

  

- PEER_1_BCP="9051"

- PEER_2_BCP="10051"

#ORDERERS

- ORDERER_1_BCP="8050"

  

#COUCHDB

  

- COUCHDB_BCP_PEER_1="7984"

- COUCHDB_BCP_PEER_2="8984"

  
Note :- You can set ports for **ESP** as same as other organization ports (only if ESP is on different machine (different IP) than that organization)  in this file if **ESP** is going to deploy on different machine e.g. if PEER_1_BCP = 7051 then PEER_1_ESP =7051 also if and only if BCP and ESP are on different machines from each other.(Same is for other ports) 

For **ESP** replace (if required) the following ports with your desired port numbers :-

#PEERS

  

- PEER_1_ESP="11051"

- PEER_2_ESP="12051"

#ORDERERS

- ORDERER_1_ESP="9050"

  

#COUCHDB

  

- COUCHDB_ESP_PEER_1="9984"

- COUCHDB_ESP_PEER_2="10984"

  

>

Note :- You can set ports for **BROKER** as same as other organization ports (only if ESP is on different machine (different IP) than that organization)  in this file if **BROKER** is going to deploy on different machine e.g. if PEER_1_ESP = 7051 then PEER_1_BROKER =7051 also if and only if ESP and BROKER are on different machines from each other.(Same is for other ports)    

For **BROKER** replace (if required) the following ports with your desired port numbers :-

#PEERS

  

- PEER_1_BROKER="13051"

- PEER_2_BROKER="14051"

#ORDERERS

- ORDERER_1_BROKER="10050"

  

#COUCHDB

  

- COUCHDB_BROKER_PEER_1="10984"

- COUCHDB_BROKER_PEER_2="11984"

  

  

>

  

  

  

  

>

  

  

  

  

>

  

  

  

  

>

  

  

  

  

  

  

**Now to generate config file for all Machines Run :-**

  

  

  

  

  

  

  

`./scratch/generate-peer-base.sh hlf`

  

`./scratch/generate-network-files.sh`

  

  

  

  

  

where **hlf** is a parameter

  

  

  

  

  

  

  



  


  

  



  

  

  

  

  

  

  

## Generate Genesis block and channel tx

  

  

  

  

  

  

***In HLF 1 machine***

  

  

  

  

  

  

  

Run the following command in HLF 1 machine

  

  

  

  

  

  

  

`./scratch/genesis.sh`

  

  

  

  

  

  

  

*** This will create genesis block and channel tx file

  

  

  

  

  

  

  

***Note:- system-genesis-file folder will be created (hlf-volume/hyperledger/system-genesis-file ) in HLF 1 Machine***

  

  

  

  

  

  

  


  

## Create ccp connection files

  

  

  

  

  

  

***In HLF 1 machine***

  

  

  

  

run

  

  

  

  

  

  

`./scratch/ccp-generate.sh`

  

  

  

  

  

  

  

This will create connection files for respective organizations in organization/peerOrganizations/{org_name}.osqo.com where {org_name} is name of organization

  

  

  

  

  

  

  

***Note:- This file will be used for running explorer,SDK.***  

  


  

  

**Create a zip file name certs.zip  with below given commands and  copy this zip file to other instances/machines  where organizations will be deployed (i.e. if  other organizations will be deployed to other different instances/machines)**

  

  

  

  

  

  

***In HLF 1 machine***

  

  

  

  

  

  

  

**Create zip files for certificates,genesis file and folders :-**

  

  

  

  

  

Run below given command to create zip files in HLF 1 machine

  

  

  

  

  

  

  

  

`./scratch/zip-certificate-data.sh`

  

  

  

  

  

It will create zip file named certs.zip for below folders :-

  

  

  

  

*docker-compose-ca*


*configtx*

*docker-compose-network*

  

 *set-automate-configuration.sh* 

  

  

  

  

  

*orgranizations*

  

  

  

  

  

  

  

*system-genesis-file*

  

  

  

  

  

  

  

*channel-artifacts*

  

  

  

  

  
in hyperledger folder whose path would be

  

  

  

  

**

  

  

  

  

  

> /hlf-volume/hyperledger/certs.zip

  

  

  

  

  

**

  

  

  

  

  

in HLF 1 machine

**Create a zip file name explorer-data.zip in HLF 1 machine from scripts folder :-**

`./scratch/zip-explorer-data.sh`



**Now copy the certs.zip file from HLF 1 to other machines (except sdk and explorer machines) in hyperledger folder of every machine one by one at path :-** 

> /hlf-volume/hyperledger/




Then **unzip** this **certs.zip** file on other  instances (except sdk and explorer machine) one by one using commands :- 

Note :- Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.



`cd /hlf-volume/hyperledger/scripts`

`./unzip-certificate-data.sh`

`./set-peer-base.sh etc`






## ACTUAL DEPLOYMENT SECTION

  
## OSQO ORGANIZATION DEPLOYMENT
  
**Open the machine where you want to deploy **OSQO** organization (open that machine whose IP was set for OSQO in IP and port configuration file .i.e set-automate-coniguartion.sh file)**

***Deploy the network containers for orgs. of OSQO :-***

**From scripts folder run :-** 



  

  

  

  

  

  



  

  

  

  

  

  

  
  
  

  

  

  

  

  

  



  

  

  

  

  

`./start-org.sh osqo`

  

  

  

  

  

  

  

  

  

  

  

  

  


  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

## BCP ORGANIZATION DEPLOYMENT

Open the machine where you want to deploy **BCP** organization (open that machine whose IP was set for BCP in IP and port configuration file .i.e set-automate-coniguartion.sh file)

***Deploy the network containers for orgs. of BCP :-***

**From scripts folder run :- **

`./start-org.sh bcp`


## ESP ORGANIZATION DEPLOYMENT

Open the machine where you want to deploy **ESP** organization (open that machine whose IP was set for ESP in IP and port configuration file .i.e set-automate-coniguartion.sh file)


***Deploy the network containers for orgs. of ESP :-***

**From scripts folder run :- **

`./start-org.sh esp`



## BROKER ORGANIZATION 

Open the machine where you want to deploy **BROKER** organization (open that machine whose IP was set for BROKER in IP and port configuration file .i.e set-automate-coniguartion.sh file)


***Deploy the network containers for orgs. of BROKER :-***

**From scripts folder run :- **

`./start-org.sh broker`



  

  

  

**For OSQO deployed machine***

  

  

  

1. Open AWS account and select the osqo machine instance

  

  

  

2. Inside security groups open launch wizard

  

  

  

3. Select inbound rules and then click on edit inbound rules

  

  

  

4. Click on **Add rule**,

  

  

  

  

5. Select **All traffic** in Type option

  

  

  

6. Add IP address of **OSQO** machine itself (so that osqo peers can connect to each other) by 32 in source fill up e.g. **{OSQO-Machine-IP}/32**

  

  

  

7. Add **name of your choice** as name in description box

  
  

8. Click on **Add rule** again,

  

  

  

10. Select **All traffic** in Type option

  

  

  

11. Add IP address of **BCP** machine (whether **BCP** is on different machine or on same as OSQO) by 32 in source fill up e.g. **{BCP-Machine-IP}/32** (Ignore if same IP entry already exists in osqo machine inbounds).

  

  

  

12. Add **name of your choice** as name of machine in description box

  
  

  

  

13. Click on **Add rule** again,

  

  

  

14. Select **All traffic** in Type option

  

  

  

15. Add IP address of **ESP** (if **ESP** is on different machine than OSQO) by 32 in source fill up e.g. **{ESP-Machine-IP}/32** . (Ignore if same IP entry already exists in osqo machine inbounds).

  

  

  

16. Add **name of your choice** as name of ESP machine in description box

  

  

  

17. Click on **Add rule** again,

  

  

  

18. Select **All traffic** in Type option

  

  

  

19. Add IP address of **BROKER** (if**BROKER** is on different machine than OSQO) machine by 32 in source fill up e.g. **{BROKER-Machine-IP}/32**(Ignore if same IP entry already exists in osqo machine inbounds).

  
  

  

  

20. Add **name of your choice** as name of machine in description box

  

  

  

  

***For BCP  deployed machine***

  

  

  

1. Open AWS account and select the **BCP** machine instance

  

  

  

2. Inside security groups open launch wizard

  

  

  

3. Select inbound rules and then click on edit inbound rules

  
  

4. Click on **Add rule**,

  

  

  

5. Select **All traffic** in Type option

  

  

  

6. Add IP address of **BCP** itself (so that bcp peers can interact). (Ignore if same IP entry already exists in bcp machine inbounds).

  

  

  

7. Add **name of your choice** in description box

  
  

  

  

5. Click on **Add rule** again,

  

  

  

6. Select **All traffic** in Type option

  

  

  

7. Add IP address of **OSQO** machine (if**OSQO** is on different machine than **BCP**) by 32 in source fill up e.g. **{OSQO-Machine-IP}/32**. (Ignore if same IP entry already exists in osqo machine inbounds).

  

  

  

8. Add **name of your choice** in description box

  

  

`./scratch/zip-channel-block.sh`

  

9. Click on **Add rule** again,

  

  

  

10. Select **All traffic** in Type option

  

  

  

11. Add IP address of **ESP** (if **ESP** is on different machine than bcp) by 32 in source fill up e.g. **{ESP-Machine-IP}/32**.(Ignore if same IP entry already exists in bcp machine inbounds).

  

  

  

12. Add **name of your choice** in description box

  

  

  

13. Click on **Add rule** again,

  

  

  

14. Select **All traffic** in Type option

  

  

  

15. Add IP address of **BROKER** (if **BROKER** is on different machine than bcp) machine by 32 in source fill up e.g. **{BROKER-Machine-IP}/32**.(Ignore if same IP entry already exists in bcp machine inbounds).

  

  

  

16. Add name of your choice in description box

  

  

  

***For ESP instance ***

  

  

  

1. Open AWS account and select the ESP machine instance

  

  

  

2. Inside security groups open launch wizard

  

  

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**,

  

  

  

5. Select **All traffic** in Type option

  

  

  

6. Add IP address of **ESP** itself (so that esp peers can interact) by 32 in source fill up. e.g. **{ESP-Machine-IP}/32**(Ignore if same IP entry already exists in esp machine inbounds).

  

  

  

7. Add **name of your choice** in description box

  
  

  

  

5. Click on **Add rule** again,

  

  

  

6. Select **All traffic** in Type option

  

  

  

7. Add IP address of **OSQO** machine (**OSQO** is on different machine than ESP) by 32 in source fill up e.g. **{OSQO-Machine-IP}/32**

  

  

  

8. Add name of your choice in description box

  

  

  

9. Click on **Add rule** again,

  

  

  

10. Select **All traffic** in Type option

  

  

  

11. Add IP address of **BCP** machine (if **BCP** is on different machine than ESP) by 32 in source fill up e.g. **{BCP-Machine-IP}/32****.(Ignore if same IP entry already exists in esp machine inbounds).

  
  

  

  

12. Add **name of your choice** as name of BCP machine in description box

  

  

  

13. Click on **Add rule** again,

  

  

  

14. Select **All traffic** in Type option

  

  

  

15. Add IP address of **BROKER** machine (if **BROKER** is on different machine than ESP) by 32 in source fill up e.g. **{BROKER-Machine-IP}/32**.(Ignore if same IP entry already exists in esp machine inbounds).

  
  

  

  

16. Add name of your choice in description box

  

  

  

  

***For BROKER instance ***

  

  

  

1.1. Open AWS account and select the **BROKER** machine instance

  

  

  

2. Inside security groups open launch wizard

  

  

  

3. Select inbound rules and then click on edit inbound rules

  
  

4. Click on **Add rule**,

  

  

5. Select **All traffic** in Type option

  

  

  

6. Add IP address of **BROKER** itself (so that broker peers can interact) by 32 in source fill up. e.g. **{BROKER-Machine-IP}/32**(Ignore if same IP entry already exists in esp machine inbounds).

  

  

  

7. Add **name of your choice** in description box

  
  

  

  

5. Click on **Add rule**,

  

  

  

6. Select **All traffic** in Type option

  

  

  

7. Add IP address of **OSQO** machine (if **BROKER** is on different machine than OSQO) by 32 in source fill up e.g. **{OSQO-Machine-IP}/32**.(Ignore if same IP entry already exists in esp machine inbounds).

  

  

  

8. Add name of your choice in description box

  

  

  

9. Click on **Add rule** again,

  

  

  

10. Select **All traffic** in Type option

  

  

  

11. Add IP address of **BCP** machine (if**BROKER** is on different machine than BCP) by 32 in source fill up e.g. **{BCP-Machine-IP}/32****.(Ignore if same IP entry already exists in esp machine inbounds).

  
  

  

  

12. Add name of your choice in description box

  

  

  

13. Click on **Add rule** again,

  

  

  

14. Select **All traffic** in Type option

  

  

  

15. Add IP address of **ESP** machine (if**BROKER** is on different machine than ESP) by 32 in source fill up e.g. **{ESP-Machine-IP}/32**.(Ignore if same IP entry already exists in esp machine inbounds).

  

  

  

16. Add name of your choice in description box as name of ESP machine

  

  

## AGAIN MOVE TO MACHINE WHERE OSQO IS DEPLOYED
  

  

  

  

  

  

***Note :- If not in scripts folder then move to scripts folder first from***

  

  

  

  

  

  

  

>  **/hlf-volume/hyperledger/**

by using command :- 

  `cd /hlf-volume/hyperledger/scripts`

  

  

  

  

  

  


  

  

  

  

  

  

  

  

  

## Create channel

  

  

  

  

  

  

***In OSQO machine***

  

  

  

  

  

  

  

**Create channel**

  

  

  

  

  

  

  

  

`./scratch/create-channel.sh`

  

  

  

  

  

  

  

  

  

From scripts folders run below given commands

  

  

  

  

  

  

  

**If already in scripts folder then run :-**

  

  

  

  

**From OSQO deployed machine zip the channel artifacts folder using command :- **

  

  

`./scratch/zip-channel-block.sh`

  

## Copy `channel-block.zip` file from OSQO machine hyperledger directory i.e.

> /hlf-volume/hyperledger/channel-block.zip

 to  

> **/hlf-volume/hyperledger/**

 folder  of other organization's machine (except sdk and explorer machine) one by one different from **OSQO** machine 
  
## Unzip channel-block.zip file on each machine

From scripts folder run :- 

`unzip -o -d ../ ../channel-block.zip`  


## JOIN CHANNEL

**Move to machine where OSQO is deployed**

_**Note :- If not in scripts folder then move to scripts folder first from**_

> **/hlf-volume/hyperledger/**

by using command :-

`cd /hlf-volume/hyperledger/scripts`


Join channel on OSQO using commands :-

  

  

  

`./scratch/join-channel-org.sh osqo`


**Move to machine where BCP is deployed**

_**Note :- If not in scripts folder then move to scripts folder first from**_

> **/hlf-volume/hyperledger/**

by using command :-

`cd /hlf-volume/hyperledger/scripts`

Join channel on BCP using commands :-

  

  

  

`./scratch/join-channel-org.sh bcp`


**Move to machine where ESP is deployed**

_**Note :- If not in scripts folder then move to scripts folder first from**_

> **/hlf-volume/hyperledger/**

by using command :-

`cd /hlf-volume/hyperledger/scripts`

Join channel on ESP using commands :-

  

  

  

`./scratch/join-channel-org.sh esp`

  
**Move to machine where BROKER is deployed**

_**Note :- If not in scripts folder then move to scripts folder first from**_

> **/hlf-volume/hyperledger/**

by using command :-

`cd /hlf-volume/hyperledger/scripts`

Join channel on BROKER using commands :-

  

  

  

`./scratch/join-channel-org.sh broker`
  


  





## INSTALL CHAINCODE 






  

  

  


  

  

  

## Move to BROKER deployed machine and Install chaincode

  

  

  

  

  


***Note :- If not in scripts folder then move to scripts folder first from***

  

  

  

  

  

  

  

>  **/hlf-volume/hyperledger/**

by using command :- 

  `cd /hlf-volume/hyperledger/scripts`

  
  
***In BROKER machine***

  

  

  

  

  

  

  

*** This will deploy the chaincode on broker organization of Broker machine.

  

  

  

  

  

  

  

**BROKER**

  

  

  

  

  

  

***Install chaincode for Broker by following command:-***

  

  

  

  

  

  
Note :- Replace name of additional volume in below commands (if you have set name of volume other than **hlf-volume**) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.
  

`./chaincode/install-chaincode.sh broker osqo-chaincode /hlf-volume/hyperledger-sdk/osqo-chaincode 1.0 1`

  

  

  

  

  

  

  

**Parameters here are :-**

  

  

  

  

  

  

**broker** is name of organization (1st parameter)

  

  

  

  

  

  

  

**osqo-chaincode** is name of chaincode (2nd parameter)

  

  

  

  

  

  

  

**/hlf-volume/hyperledger-sdk/osqo-chaincode** is path of chaincode (3rd parameter) where {hlf-volume} is other location where chaincode is located.

  

  

  

  

  

  

  

**1.0** is the version of chaincode (4th parameter)

  

  

  

  

  

  

  

**1** is the sequence of chaincode (5th parameter)

  

  

## Move to ESP deployed machine and Install chaincode

  

  


  

  

  

  



  

  


  


***Note :- If not in scripts folder then move to scripts folder first from***

  

  

  

  

  

  

  

>  **/hlf-volume/hyperledger/**

by using command :- 

  `cd /hlf-volume/hyperledger/scripts`

  

  

  

  

  

  

  

  

  

*** This will deploy the chaincode on esp organization of ESP machine.

  

  

  

  

  

  

  

**ESP**

  

  

  

  

  

  

***Install chaincode for ESP by following command:-***

  

  

  

**Note :- Replace name of additional volume in below commands (if you have set name of volume other than **hlf-volume**) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.**

  

  

  

`./chaincode/install-chaincode.sh esp osqo-chaincode /hlf-volume/hyperledger-sdk/osqo-chaincode 1.0 1`

  

  

  

  

  

  

  

**Parameters here are :-**

  

  

  

  

  

  

**esp** is name of organization (1st parameter)

  

  

  

  

  

  

  

**osqo-chaincode** is name of chaincode (2nd parameter)

  

  

  

  

  

  

  

**/hlf-volume/hyperledger-sdk/osqo-chaincode** is path of chaincode (3rd parameter) where {hlf-volume} is other location where chaincode is located.

  

  

  

  

  

  

  

**1.0** is the version of chaincode (4th parameter)

  

  

  

  

  

  

  

**1** is the sequence of chaincode (5th parameter)

  

  

  

  

  

  

  

  

## Move to BCP deployed machine and Install chaincode 

  

  



  

  


  

  


  

  


  

  


***Note :- If not in scripts folder then move to scripts folder first from***

  

  

  

  

  

  

  

>  **/hlf-volume/hyperledger/**

by using command :- 

  `cd /hlf-volume/hyperledger/scripts`

  

  

  



  

  

  

  

  

  

  


  

  

  

  

  

  

  

**BCP**

  

  

  

  

  

  

***Install chaincode for BCP by following command:-***

*** This will deploy the chaincode on BCP organization in BCP machine.


  

  

  

  
**Note :- Replace name of additional volume in below commands (if you have set name of volume other than **hlf-volume**) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.**

  

`./chaincode/install-chaincode.sh bcp osqo-chaincode /hlf-volume/hyperledger-sdk/osqo-chaincode 1.0 1`

  

  

  

  

  

  

  

**Parameters here are :-**

  

  

  

  

  

  

**bcp** is name of organization (1st parameter)

  

  

  

  

  

  

  

**osqo-chaincode** is name of chaincode (2nd parameter)

  

  

  

  

  

  

  

**/hlf-volume/hyperledger-sdk/osqo-chaincode** is path of chaincode (3rd parameter) where {hlf-volume} is other location where chaincode is located.

  

  

  

  

  

  

  

**1.0** is the version of chaincode (4th parameter)

  

  

  

  

  

  

  

**1** is the sequence of chaincode (5th parameter)

  

  

  

  

  

  

## Move to OSQO deployed machine and install chaincode

  

  



  

  

  


  

***Note :- If not in scripts folder then move to scripts folder first***


**Move to hlf-volume/hyperledger/scripts using command :-**

  

  

`cd hyperledger/scripts`

  

  

  

  

  


  

  

  

  

  

  

  

>  **/hlf-volume/hyperledger/scripts**

  

  

  

  

  

  

  

  

  

  

***Note :- If not in scripts folder then move to scripts folder first***


  

  

## Install chaincode on OSQO Organization

  

  

  

  

  

  



  

  

  

  

  

  

  



  

  

  

  

  

  



  

  

  

  

  

**Install chaincode for OSQO by following command:-**
This will deploy the chaincode on osqo organization.
  

  

  

  

  
Note :- Replace name of additional volume in below commands (if you have set name of volume other than **hlf-volume**) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.

  

`./chaincode/install-chaincode.sh osqo osqo-chaincode /hlf-volume/hyperledger-sdk/osqo-chaincode 1.0 1`

  

  

  

  

  

  

  

*****Parameters here are :-**

  

  

  

  

  

  

  

**osqo** is name of organization (1st parameter)

  

  

  

  

  

  

  

**osqo-chaincode** is name of chaincode (2nd parameter)

  

  

  

  

  

  

  

**/hlf-volume/hyperledger-sdk/osqo-chaincode** is path of chaincode (3rd parameter) where {hlf-volume} is other location where chaincode is located.

  

  

  

  

  

  

  

**1.0** is the version of chaincode (4th parameter)

  

  

  

  

  

  

  

**1** is the sequence of chaincode (5th parameter)

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

## Commit chaincode

  

  

  

  

  

  
**In machine where  OSQO is deployed run the following commands :-** 

  

  

  

  

  

  

  

** This will commit the chaincode after every organization in network has approved the chaincode.

  

  

  

  

  

  

  

**In OSQO machine from scripts folder run command:-**

  

  

  

  

  ***Note :- If not in scripts folder then move to scripts folder first***


**Move to hlf-volume/hyperledger/scripts using command :-**

  

`cd hyperledger/scripts`

  **Then run :-**

`./chaincode/commit-chaincode.sh osqo osqo-chaincode 1.0 1`

  

  

  

  

  

  

  

*****Parameters here are :-**

  

  

  

  

  

  

  

**osqo** is name of organization (1st parameter)

  

  

  

  

  

  

  

**osqo-chaincode** is name of chaincode (2nd parameter)

  

  

  

  

  

  

  

**1.0** is the version of chaincode (3rd parameter)

  

  

  

  

  

  

  

**1** is the sequence number of chaincode (5th parameter)

  

  

  

  

  

  

  


  

  

  

  

  

  

  


  

  

  

  

  

  


  

  

  

  

  

  

  

## Setup SDK

  

  

  

  

  

  


  

  

  

  

  

  

This will be used to interact with installed chaincode on network. It provides apis to submit transactions to ledger or query contents of ledger.

  

  

**In case if you want to run SDK on different machine like **SDK-MACHINE** than **OSQO, BCP, ESP or BROKER** machines then

**Follow step 1**




**In case if you want to run SDK on one of the same machine where other organization is deployed **(OSQO, BCP, ESP or BROKER)** machines then
  
**Follow step 2**






> - ## STEP 1

Clone the hyperledger-sdk repo in **SDK-MACHINE** on root location of machine (if there is no addtional volume on that instance/machine) from given link :-**

If there is no additional volume in SDK-MACHINE then run these commands :-


`git clone https://tejindermethodbridge@bitbucket.org/osqo/hyperledger-sdk.git`


Move to sdk folder:-

`
`



OR 


Or in case you have additional volume then move to additional volume and clone the hyperledger-sdk repo in **SDK-MACHINE** on additional volume location of machine (if there is an addtional volume on that instance/machine) from given link :-**




Note :- Replace name of additional volume in below commands (if you have set name of volume other than **hlf-volume**) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.
  

`cd /hlf-volume` 

`git clone https://tejindermethodbridge@bitbucket.org/osqo/hyperledger-sdk.git`



Note :- Replace name of additional volume in below commands (if you have set name of volume other than **hlf-volume**) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.
  

`cd /hlf-volume/hyperledger-sdk`

  


  
Note :- Now copy the connection file of **OSQO** from HLF 1 machine at path **

> /hlf-volume/hyperledger/organizations/peerOrganizations/osqo.osqo.com/connection-osqo.json

** to 

> hyperledger-sdk/

 folder in SDK-Machine :-

  
Rename file to  connection-org1.json using command:-  

`mv connection-osqo.json connection-org1.json`  



  

  

  

  

***in SDK-MACHINE***

  

  

  

  

  

**Create Peer Base file for SDK-MACHINE **

  

  

  

  

  

  

  

  

  

  

  

Update IP addresses for nodes of **OSQO**, **BCP** , **ESP**, **BROKER** machines by replacing the old IP address entries with new IP addresses in **set-automate-ip.sh** file in hyperledger-sdk/set-automate-ip.sh file

  

  

  

  

  

  

  

**To create host file for SDK-MACHINE nodes:-**

  

  

  

  

  

  

  

***OPEN*** set-automate-ip.sh file located at

  

  

  

  

  

  

  

**

  

  

  

  

  

>  **/hyperledger-sdk/set-automate-ip.sh**

  

  

  

  

  

**

  

  

  

  

  

  

  

file in SDK-MACHINE

  

  

  

  

  

  

  

*** Add the IP addresses for **OSQO, BCP, ESP and BROKER**

  

  

  

  

  

  

  

**REPLACE** the followings in set-automate-ip.sh file :-

  

  

  

  

  

  

- OSQO_IP={OSQO IP}

  

- BCP_IP={BCP IP}

  

  

  

  

  

  

- ESP_IP={ESP IP}

  

  

  

  

  

  

- BROKER_IP={BROKER IP}

  

  

  

  

  

  

  

  

  

  

where **{OSQO IP}, {BCP IP} , {ESP IP} , {BROKER IP} ** are the IP address of OSQO, BCP , ESP and BROKER

   e.g. if IP address of OSQO machine is **54.252.142.45** then

  

> OSQO_IP=54.252.142.45

  

> IP address of BCP machine is **3.27.44.202** then

  

> BCP_IP=3.27.44.202

  

> if IP address of ESP machine is **13.236.135.224** then

  

> ESP_IP=13.236.135.224

  

> if IP address of BROKER machine is **13.236.209.144** then

  

> BROKER_IP=13.236.209.144

  

  

  

  

  

  



  

  

  

  

>

  

  

  

  

>

  

  

  

  

>

  

  

  

  

>

  

  

  

  

>

  

  

  

  

  

  

**Open the port no. on aws account for SDK  in instance where SDK is deployed :-**

  

_**For SDK instance (SDK-MACHINE)**_

  

  

1. Open AWS account and select the SDK machine instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **Custom TCP** in Type option

  

6. Add port range as **3000**

  

7. Add 0.0.0.0./0 Anywhere in source fill up

  

8. Add SDK-PORT as name in description box

  

  

Open the port no. for SDK in  OSQO instance on aws account:-**

  

_**In OSQO deployed machine instance**_
  


1. Open AWS account and select the **OSQO** machine  instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **All TCP** in Type option

  

6. Add **{SDK-MACHINE-IP}/32** in source fill up 
	OR
(if running sdk in OSQO or BCP or ESP or BROKER machine then add that machine IP address in place of **{SDK-MACHINE-IP}**

  

7. Add "ports for sdk" as description in description box 




  
**In BCP deployed machine instance**_

  

1. Open AWS account and select the **BCP** machine  instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **All TCP** in Type option

  

6. Add **{SDK-MACHINE-IP}/32** in source fill up 
	OR
(if running sdk in OSQO or BCP or ESP or BROKER machine then add that machine IP address in place of **{SDK-MACHINE-IP}**

  

7. Add "ports for sdk" as description in description box 






**In ESP deployed machine instance**_

  

1. Open AWS account and select the **ESP** machine  instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **All TCP** in Type option

  

6. Add **{SDK-MACHINE-IP}/32** in source fill up 
	OR
(if running sdk in OSQO or BCP or ESP or BROKER machine then add that machine IP address in place of **{SDK-MACHINE-IP}**

  

7. Add "ports for sdk" as description in description box 

  



**In BROKER deployed machine instance**_

  

1. Open AWS account and select the **BROKER** machine  instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **All TCP** in Type option

  

6. Add **{SDK-MACHINE-IP}/32** in source fill up 
	OR
(if running sdk in OSQO or BCP or ESP or BROKER machine then add that machine IP address in place of **{SDK-MACHINE-IP}**

  

7. Add "ports for sdk" as description in description box   
  

**Now from hyperledger-sdk root folder run command inside terminal :-**

  

`./seperate-sdk-start.sh`  

  

  

  
> - ## STEP 2

**(In case deploying SDK in one of machine where atleast one of the organization(OSQO, BCP, ESP, BROKER) is deployed)**  

Clone the hyperledger-sdk repo on root location of the machine (if there is no addtional volume on that instance/machine) from given link :-**

If there is no additional volume in SDK-MACHINE then run these commands :-


`git clone https://tejindermethodbridge@bitbucket.org/osqo/hyperledger-sdk.git`


Move to sdk folder:-

`cd hyperledger-sdk/`



OR 


Move to additional volume and clone the hyperledger-sdk repo on additional volume location (if sdk is not already cloned on that machine) of machine (if there is an addtional volume on that instance/machine) from given link :-**




Note :- Replace name of additional volume in below commands (if you have set name of volume other than **hlf-volume**) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.
  

`cd /hlf-volume` 

`git clone https://tejindermethodbridge@bitbucket.org/osqo/hyperledger-sdk.git`



Note :- Replace name of additional volume in below commands (if you have set name of volume other than **hlf-volume**) to be the name you had set in **`install-prereq.md file`**  **(in mount additional volume section)**.
  

`cd /hlf-volume/hyperledger-sdk`

  




  

  

  



  

  

  

  

  

**Create Peer Base file for MACHINE **

  

  

  

  

  

  

  

  

  

  

  

Update IP addresses for nodes of **OSQO**, **BCP** , **ESP**, **BROKER** machines by replacing the old IP address entries with new IP addresses in **set-automate-ip.sh** file in hyperledger-sdk/set-automate-ip.sh file

  

  

  

  

  

  

  

**To create host file for SDK-MACHINE nodes:-**

  

  

  

  

  

  

  

***OPEN*** set-automate-ip.sh file located at

  

  

  

  

  

  

  

**

  

  

  

  

  

>  **/hyperledger-sdk/set-automate-ip.sh**

  

  

  

  

  

**

  

  

  

  

  

  

  

file in MACHINE

  

  

  

  

  

  

  

*** Add the IP addresses for **OSQO, BCP, ESP and BROKER**

  

  

  

  

  

  

  

**REPLACE** the followings in set-automate-ip.sh file :-

  

  

  

  

  

  

- OSQO_IP={OSQO IP}

  

- BCP_IP={BCP IP}

  

  

  

  

  

  

- ESP_IP={ESP IP}

  

  

  

  

  

  

- BROKER_IP={BROKER IP}

  

  

  

  

  

  

  

  

  

  

where **{OSQO IP}, {BCP IP} , {ESP IP} , {BROKER IP} ** are the IP address of OSQO, BCP , ESP and BROKER

   e.g. if IP address of BCP machine is **54.252.142.45** then

  

> OSQO_IP=54.252.142.45

  

> IP address of BCP machine is **3.27.44.202** then

  

> BCP_IP=3.27.44.202

  

> if IP address of ESP machine is **13.236.135.224** then

  

> ESP_IP=13.236.135.224

  

> if IP address of BROKER machine is **13.236.209.144** then

  

> BROKER_IP=13.236.209.144

  

  

  

  

  

  



  

  

  

  

>

  

  

  

  

>

  

  

  

  

>

  

  

  

  

>

  

  

  

  

>

  

  

  

  

  

  

**Open the port no. on aws account for SDK in instance where SDK is deployed :-**

  

_**For SDK instance (SDK-MACHINE)**_

  

1. Open AWS account and select the SDK machine instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **Custom TCP** in Type option

6. Add port range as **3000**

  

7. Add 0.0.0.0./0 Anywhere in source fill up

  

8. Add SDK-PORT as name in description box

  

  

Open the port no. for SDK in  OSQO instance on aws account:-**

  



_**In OSQO deployed machine instance**_
  


1. Open AWS account and select the **OSQO** machine  instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **All TCP** in Type option

  

6. Add **{SDK-MACHINE-IP}/32** in source fill up 
	OR
(if running sdk in OSQO or BCP or ESP or BROKER machine then add that machine IP address in place of **{SDK-MACHINE-IP}**

  

7. Add "ports for sdk" as description in description box 




  
**In BCP deployed machine instance**_

  

1. Open AWS account and select the **BCP** machine  instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **All TCP** in Type option

  

6. Add **{SDK-MACHINE-IP}/32** in source fill up 
	OR
(if running sdk in OSQO or BCP or ESP or BROKER machine then add that machine IP address in place of **{SDK-MACHINE-IP}**

  

7. Add "ports for sdk" as description in description box 






**In ESP deployed machine instance**_

  

1. Open AWS account and select the **ESP** machine  instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **All TCP** in Type option

  

6. Add **{SDK-MACHINE-IP}/32** in source fill up 
	OR
(if running sdk in OSQO or BCP or ESP or BROKER machine then add that machine IP address in place of **{SDK-MACHINE-IP}**

  

7. Add "ports for sdk" as description in description box 

  



**In BROKER deployed machine instance**_

  

1. Open AWS account and select the **BROKER** machine  instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules and then click on edit inbound rules

  

4. Click on **Add rule**

  

5. Select **All TCP** in Type option

  

6. Add **{SDK-MACHINE-IP}/32** in source fill up 
	OR
(if running sdk in OSQO or BCP or ESP or BROKER machine then add that machine IP address in place of **{SDK-MACHINE-IP}**

  

7. Add "ports for sdk" as description in description box   

  

  

**Now from hyperledger-sdk root folder run command inside terminal :-**

  

  

`./new-sdk-start.sh`

  

  

  

  

  

  

  

***NOTE:-Import osqo postman collection from /hlf-volume/hyperledger-sdk/New-osqo-sdk-collections-sdk-server.postman_collection.json into postman***
  



## Start Explorer

  

  

  

  

  

  

## Move to different machine (different from OSQO, BCP, ESP Or Broker machine) to deploy explorer 

  

  

  
**Create a new folder name hyperledger on root location using command:-**

  `mkdir hyperledger`

  
**Now copy explorer-data.zip folder from HLF 1 machine (where certificates were generated .i.e. used in certificate section) to explorer's hyperledger  folder**

>   /hyperledger 

***Move to hyperledger folder using command :- ***

  `cd hyperledger`


  **Unzip the folder using command :-**

`unzip -o -d ./ ./explorer-data.zip`


**add /etc/hosts entries :-**
`./set-peer-base.sh etc`




***Do this from the instance where explorer is running (explorer machine)***

  

1. Open AWS account and select the **explorer** machine instance

  

2. Inside security groups open launch wizard

  

3. Select inbound rules for and then click on edit inbound rules

  

4. Click on **Add rule**,

  

5. Select **Custom TCP** in Type option

  

6. Add **Port Range** as 80

  

7. From Source box dropdown select Anywhere option .i.e **0.0.0.0/0**

  

8. Add **HLF-EXPLORER PORT** as name in description box




**OPEN OSQO PEER 1 port for Explorer** 

1. Open AWS account and select the **osqo** machine instance

  


2. Inside security groups open launch wizard

  

  

3. Select inbound rules for and then click on edit inbound rules

  

  

4. Click on **Add rule**,

  

  

5. Select **Custom TCP** in Type option

  

  

6. Add **Port Range** as {Port of PEER_1_OSQO}

  

  

7. From Source box dropdown select {EXPLORER_IP} option .i.e **13.236.209.144/32**

  

  

8. Add **HLF-EXPLORER** as name in description box



***Move to hyperledger folder using command (if not in hyperledger directory in explorer instance) :- ***

  `cd hyperledger`



**Run explorer using command :-** 

`./scratch/start-explorer.sh`

  

  



  

  

  

  

  

  

  

  

  

  

  

Hit the url http://**{EXPLORER_MACHINE_IP}**:80/

  

  

  

  

  

  

where **{EXPLORER_MACHINE_IP}** is IP address of machine where explorer is running


  

**MAIN SETUP COMPLETED**

  

  

## RESTART DOCKER CONTAINERS AUTOMATICALLY IN CASE OF RESTARTING MACHINE

  

  

  

**If you want all running docker containers to restart automatically in case of machine restart , do the followings :-

  

  

After setting up the whole network , installing chaincode, setting up sdk , setting up explorer run the following command on every machine :-**

  

  

  

(Before running this command all required containers should be in running state).

  

  

  

`docker update --restart unless-stopped $(docker ps -q)`

  

  

  

**Note:-** Run this command as last step on every machine so that whichever machine restart's, docker containers starts automatically.

  

  

  

  

  

## SETUP COMPLETED 