To setup HLF network

1.First go through HLF VPC SETUP  file  to setup VPC environemnt for HLF network.

2.Now download the prerequisites files on every machine (at root location) from given  below links :- 

1. curl -LJO https://raw.githubusercontent.com/navpreet-debut/utils/main/automate-prereq-1.sh

2. curl -LJO https://raw.githubusercontent.com/navpreet-debut/utils/main/automate-prereq-2.sh

3. Now run both  downloaded files from root location one by one on every machine using commands :-

chmod +x automate-prereq-1.sh

chmod +x automate-prereq-2.sh

./automate-prereq-1.sh

./automate-prereq-2.sh



CLONE THE REPO

ON EACH PRIVATE MACHINE

Follow the following steps on each organization machine

Move to additional volume named hlf-volume by using following command :-

cd /hlf-volume

On each organization's private instance/machine

Clone the hyperledger repo for network configuration

Clone the hyperledger-chainoode repo for chaincode 

GENERATE NETWORK CONFIGS FILES AND CERTIFICATES

OPEN ANY MACHINE (lets say HLF 1)

In that HLF 1 machine follow the steps :-



1.Move to scripts folder using command :-

cd /hlf-volume/hyperledger/scripts

2.OPEN

set-automate-configuration.sh

file located at

/hlf-volume/hyperledger/scripts/set-automate-configuration.sh

file in HLF 1 machine :-



Update IP addresses for organizations (nodes) and ports

of OSQO, BCP, ESP, BROKER machines by replacing the old (default) IP address entries with new IP addresses and old ports (only if required) with new port numbers in set-automate-configuration.sh file in scripts folder i.e. in /hlf-volume/hyperledger/scripts/set-automate-configuration.sh file.

Change the IP addresses for OSQO, BCP, ESP, BROKER organization **



REPLACE the followings in set-automate-configuration.sh file :-

OSQO_IP={OSQO IP}

BCP_IP={BCP IP}

ESP_IP={ESP IP}

BROKER_IP={BROKER IP}

where **{OSQO IP}, {BCP IP} , {ESP IP} , {BROKER IP} ** are the IP address of OSQO, BCP , ESP and BROKER

e.g. if IP address of OSQO machine is 54.252.142.45 then

OSQO_IP=54.252.142.45

IP address of BCP machine is 3.27.44.202 then

BCP_IP=3.27.44.202

if IP address of ESP machine is 13.236.135.224 then

ESP_IP=13.236.135.224

if IP address of BROKER machine is 13.236.209.144 then

BROKER_IP=13.236.209.144





And then replace Port numbers (only if required)

Replace (if required) the following ports with your desired port numbers :-



For OSQO replace (if required) the following ports with your desired port numbers :-

#PEERS

PEER_1_OSQO="7051"

PEER_2_OSQO="6051"

#ORDERERS

ORDERER_1_OSQO="7050"

#COUCHDB

COUCHDB_OSQO_PEER_1="5984"

COUCHDB_OSQO_PEER_2="6984"



Note: You can set ports for BCP as same as other organization ports (only ifBCP is on different machine (different IP) than that organization) in this file, if OSQO is going to deploy on different machine e.g. if PEER_1_BCP = 7051 then PEER_1_OSQO =7051 also if and only if BCP and OSQO are on different machines from each other.(Same is for other ports)**

For BCP replace (if required) the following ports with your desired port numbers :-

#PEERS

PEER_1_BCP="9051"

PEER_2_BCP="10051"

#ORDERERS

ORDERER_1_BCP="8050"

#COUCHDB

COUCHDB_BCP_PEER_1="7984"

COUCHDB_BCP_PEER_2="8984"



Note: You can set ports for ESP as same as other organization ports (only if ESP is on different machine (different IP) than that organization) in this file, if ESP is going to deploy on different machine e.g. if PEER_1_BCP = 7051 then PEER_1_ESP =7051 also if and only if BCP and ESP are on different machines from each other.(Same is for other ports)**

For ESP replace (if required) the following ports with your desired port numbers :-

#PEERS

PEER_1_ESP="11051"

PEER_2_ESP="12051"

#ORDERERS

ORDERER_1_ESP="9050"

#COUCHDB

COUCHDB_ESP_PEER_1="9984"

COUCHDB_ESP_PEER_2="10984"





Note:   You can set ports for BROKER as same as other organization ports (only if ESP is on different machine (different IP) than that organization) in this file if BROKER is going to deploy on different machine e.g. if PEER_1_ESP = 7051 then PEER_1_BROKER =7051 also if and only if ESP and BROKER are on different machines from each other.(Same is for other ports)**

For BROKER replace (if required) the following ports with your desired port numbers :-

#PEERS

PEER_1_BROKER="13051"

PEER_2_BROKER="14051"

#ORDERERS

ORDERER_1_BROKER="10050"

#COUCHDB

COUCHDB_BROKER_PEER_1="10984"

COUCHDB_BROKER_PEER_2="11984"





STEP 1

From same HLF 1 machine

Run the given below command :-

./step1.sh



TRANSFER ZIP FILES 

FROM HLF 1 PRIVATE MACHINE TO OTHER PRIVATE MACHINES



1.Connect HLF 1 machine/instance through Filezilla using Tunneling Process

2. Download -

certs.zip

explorer-data.zip

sdk.zip

files

located at

/hlf-volume/hyperledger/

folder in HLF 1 machine

to

local machine storage.



Perform steps 3 to 4 on other machines apart from HLF 1 machine

3.Connect other machine (apart from HLF 1) in Filezilla through Tunneling process

4.Copy downloaded certs.zip zip file from local to

/hlf-volume/hyperledger/

folder of respective private machine (except HLF 1)



OPEN PORTS

In AWS account

1.Go to security group of the organization's instances (OSQO, BCP, ESP & BROKER)

2.Select inbound rules and then click on edit inbound rules

3.Click on Add rule

4.Select All TCP in Type option

5.Add private IP address of each organization's (OSQO, BCP, ESP & BROKER) instance/machine one by one with same type as (All TCP)

6.Add description of your choice in description box

7.Add private IP address of SDK and explorer machines one by one with same type as All TCP by same steps as 3 to 4.

8.Again Click on Add rule

9.Select Type as HTTP

10.Add 80 in Port Range

11.Add 0.0.0.0/0 (anywhere) as IP range

12.Add description of your choice



STEP 2

ACTUAL DEPLOYMENT SECTION

BCP ORGANIZATION DEPLOYMENT

1.Open that machine whose IP was set for BCP in IP and port configuration file (i.e set-automate-coniguartion.sh file)



2.Move to scripts folder using command :-

Note:  Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in install-prereq.md file (in mount additional volume section).

cd /hlf-volume/hyperledger/scripts



3.Then run the following command:-

./step2.sh bcp



ESP ORGANIZATION DEPLOYMENT

1.Open that machine whose IP was set for ESP in IP and port configuration file (i.e set-automate-coniguartion.sh file)



2.Move to scripts folder using command :-

Note:  Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in install-prereq.md file (in mount additional volume section).

cd /hlf-volume/hyperledger/scripts



3.Then run the following command:-

./step2.sh esp



BROKER ORGANIZATION DEPLOYMENT

1.Open that machine whose IP was set for BROKER in IP and port configuration file  (i.e set-automate-coniguartion.sh file)



2.Move to scripts folder :-

Note:  Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in install-prereq.md file (in mount additional volume section).

cd /hlf-volume/hyperledger/scripts



3.Then run the following command:-

./step2.sh broker



OSQO ORGANIZATION DEPLOYMENT

1.Open that machine whose IP was set for OSQO in IP and port configuration file  (i.e set-automate-coniguartion.sh file)



2.Move to scripts folder :-

Note:  Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in install-prereq.md file (in mount additional volume section).

cd /hlf-volume/hyperledger/scripts



3.Then run the following command:-

./step2.sh osqo





STEP 3

CREATE CHANNEL

Again in OSQO deployed machine

1.Run the following command:-

./step3.sh



FILE TRANSFER

Now perform below steps :-

1.Connect OSQO machine/instance through Filezilla using Tunneling Process

Tip: Go through TUNNELING PROCESS Section given at end of file to open your machine files/folders through private IP in Filezilla****



2.Download channel-block.zip file

located at

/hlf-volume/hyperledger/

folder in OSQO machine

to

local machine storage.



Perform steps 3 to 4 on other organization's machines apart from OSQO machine

3.Connect other machine (apart from OSQO) in Filezilla through Tunneling process



Tip: Go through Tunneling steps given at end of file to open your machine files/folders through private IP in Filezilla****



4.Copy downloaded channel-block.zip file 

from 

local machine storage 

to

/hlf-volume/hyperledger/

folder of other organization's private machines (except OSQO)





STEP 4

Move to BROKER Deployed Machine

1.Open that machine whose IP was set for BROKER in IP and port configuration file (i.e set-automate-coniguartion.sh file)



2.Move to scripts folder with below command (if not already) :-

Note :- Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in install-prereq.md file* (in mount additional volume section).

cd /hlf-volume/hyperledger/scripts



3.Then run the following command:-

./step4.sh broker





Move to ESP Deployed Machine



1.Open that machine whose IP was set for ESP in IP and port configuration file (i.e set-automate-coniguartion.sh file)



2.Move to scripts folder with below command (if not already) :-

Note :- Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in install-prereq.md file* (in mount additional volume section).

cd /hlf-volume/hyperledger/scripts



3.Then run the following command:-

./step4.sh esp





Move to BCP Deployed Machine

1.Open that machine whose IP was set for BCP in IP and port configuration file (i.e set-automate-coniguartion.sh file)



2.Move to scripts folder with below command (if not already) :-

Note :- Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in install-prereq.md file* (in mount additional volume section).

cd /hlf-volume/hyperledger/scripts



3.Then run the following command:-

./step4.sh bcp







Move to OSQO Deployed Machine

1.Open that machine whose IP was set for OSQO in IP and port configuration file (i.e set-automate-coniguartion.sh file)



2.Move to scripts folder with below command (if not already) :-

Note :- Replace name of additional volume in below command (if you have set name of volume other than hlf-volume) to be the name you had set in install-prereq.md file* (in mount additional volume section).

cd /hlf-volume/hyperledger/scripts



3.Then run the following command:-

./step4.sh osqo



NETWORK SETUP COMPLETED  



SETUP SDK

OPEN A PUBLIC MACHINE/INSTANCE (Created for SDK during vpc setup)



1.Clone the hyperledger-sdk repo on root



2.Move to sdk folder using command:-

cd hyperledger-sdk



3.Now copy the already sdk.zip file downloaded from local storage machine

 (i.e. file which is downloaded in TRANSFER ZIP FILE SECTION OF HLF 1)

to

hyperledger-sdk/

folder in SDK-Machine using Filezillla

Tip: To transfer file from local machine to SDK MACHINE FOLDER folllow STEPS TO CONNECT PUBLIC MACHINE Process given at the end of file



4.Now start the SDK

./start-sdk.sh

Note: Import osqo postman collection from /hlf-volume/hyperledger-sdk/New-osqo-sdk-collections-sdk-server.postman_collection.json into postman



START EXPLORER

OPEN A PUBLIC MACHINE/INSTANCE (Created for EXPLORER during vpc setup)



1.Now copy explorer-data.zip file from local machine to explorer's machine on root

 (i.e. file which is downloaded in TRANSFER ZIP FILE SECTION OF HLF 1)



2.Unzip the folder using command :-

unzip -o -d ./ ./explorer-data.zip



3.Start explorer using command :-

./scratch/start-explorer.sh



4.Run explorer in browser :- 

Hit the url http://{EXPLORER_MACHINE_PUBLIC_IP}:80/ where {EXPLORER_MACHINE_PUBLIC_IP} is IP address of machine where explorer is running

   

SETUP COMPLETED                                           



STEPS FOR TUNNELING PROCESS

(FOR CONNECTING PRIVATE MACHINE VIA FILEZILLA)



To connect private instance/machine through filezilla for file transfer use the following steps :-



1.Run the following tunneling command through terminal :-

ssh -N -L 1234:<Private_instnace_IP>:22 -i <PEM_file_key_path> ubuntu@<Public_instance_IP>

where 1234 is port number you will enter in filezilla Port box , PEM_file_key_path is path of pem file ,ubuntu is name of user,Private_instance_IP is ip address of Private machine you want to connect and Public_instance_IP is public IP address of SDK/Explorer machine.

e.g. ssh -N -L 1234:10.0.10.100:22 -i hlf-vpc-key.pem ubuntu@34.213.186.213



2.After running the above given command , open the filezilla and do the followings :-

1).Open new Site Manager

2). Select Protocol as SFTP

3). Add Host as 127.0.0.1

4). Port as 1234 as mentioned in tunneling command

5). Logon Type as Key file

6). User as ubuntu

7). In key file , enter path of PEM key file

8). Press connect

Now u have connected private instance through filezilla Now download the file you want to download from private machine to local machine .

Now disconnect the connected instance from Filezilla and also stop tunneling command running in terminal. (i.e. ssh -N -L 1234:10.0.10.100:22 -i hlf-vpc-key.pem ubuntu@34.213.186.213)

And then connect to other private machines with same Tunneling steps as mentioned above by changing respective Private IPs in and tunneling command and then connect again through filezilla with same credentials as before and copy downloaded file from local to respective private machine's folder.

STEPS TO CONNECT PUBLIC MACHINE

(SDK AND EXPLORER) VIA FILEZILLA

OPEN FILEZILLA

AND FOLLOW THE FOLLWING STEPS :-

1).Open new Site Manager

2). Select Protocol as SFTP

3). Add Host as <PUBLIC_IP_OF_MACHINE>

4). Port as 22

5). Logon Type as Key file

6). User as ubuntu

7). In key file , enter path of PEM key file

8). Press connect

Now u have connected public instance through filezilla

Now download the file you want to download from local machine to Instnace public machine at desired folder.