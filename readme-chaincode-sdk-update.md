## Chaincode, SDK UPDATE

**Take the latest pull of chaincode from Hyperledger-chaincode repo in additional volume (hlf-volume) of every organization deployed machine with below command :- **
`git clone https://tejindermethodbridge@bitbucket.org/osqo/hyperledger-chaincode.git`



*** UPDATE CHAINCODE

***To update the chaincode. Edit the install chaincode command above ***

 Go to **hyperledger ** folder  and then to **scripts** folder first from each organization (OSQO,BCP,ESP,BROKER) deployed machine using command:- 
 
`cd /hlf-volume/hyperledger/scripts`

**Note :- before updating the chaincode increment the sequence number to the next number from last deployed sequence number**

e.g. Increment the sequence number parameter e.g.increasing sequence number to 2 (if previous was 1)

  

  

**For osqo deployed machine run the following command from scripts folder :-**
  

`./chaincode/install-chaincode.sh osqo osqo-chaincode hlf-volume/hyperledger-chaincode/osqo-chaincode 1.0 2`

  

  

***Parameters here are :-

  

osqo is name of organization (1st parameter)

  

osqo-chaincode is name of chaincode (2nd parameter)

  

hlf-volume/hyperledger-chaincode/osqo-chaincode is path of chaincode (3rd parameter) 

  

1.0 is the version of chaincode (4th parameter)

  

2 is the incremented sequence number (if previous was 1) of chaincode (5th parameter)




**For bcp deployed machine run the following command from scripts folder :-**
  

`./chaincode/install-chaincode.sh bcp osqo-chaincode hlf-volume/hyperledger-chaincode/osqo-chaincode 1.0 2`

  

  

***Parameters here are :-

  

osqo is name of organization (1st parameter)

  

osqo-chaincode is name of chaincode (2nd parameter)

  

hlf-volume/hyperledger-chaincode/osqo-chaincode is path of chaincode (3rd parameter) 

  

1.0 is the version of chaincode (4th parameter)

  

2 is the incremented sequence number (if previous was 1) of chaincode (5th parameter)



**For esp deployed machine run the following command from scripts folder :-**
  

`./chaincode/install-chaincode.sh esp osqo-chaincode hlf-volume/hyperledger-chaincode/osqo-chaincode 1.0 2`

  



***Parameters here are :-

  

esp is name of organization (1st parameter)

  

osqo-chaincode is name of chaincode (2nd parameter)

  

hlf-volume/hyperledger-chaincode/osqo-chaincode is path of chaincode (3rd parameter) 

  

1.0 is the version of chaincode (4th parameter)

  

2 is the incremented sequence number (if previous was 1) of chaincode (5th parameter)

  

**For broker deployed machine run the following command from scripts folder :-**
  

`./chaincode/install-chaincode.sh broker osqo-chaincode hlf-volume/hyperledger-chaincode/osqo-chaincode 1.0 2`

  

  

***Parameters here are :-

  

broker is name of organization (1st parameter)

  

osqo-chaincode is name of chaincode (2nd parameter)

  

/hlf-volume/hyperledger-chaincode/osqo-chaincode is path of chaincode (3rd parameter) 

  

1.0 is the version of chaincode (4th parameter)

  

2 is the incremented sequence number (if previous was 1) of chaincode (5th parameter)



  
**Note :- After installing new updated chaincode on every organization , go to osqo deployed machine and commit the chaincode from scripts folder as well with new sequence number :-**

`./chaincode/commit-chaincode.sh osqo osqo-chaincode 1.0 2`



***Parameters here are :-

  

osqo is name of organization (1st parameter)

  

osqo-chaincode is name of chaincode (2nd parameter)

  

1.0 is the version of chaincode (3rd parameter)

  

2 is the incremented sequence number (if previous was 1) of chaincode (4th parameter)

  



*** UPGRADE CHAINCODE

***To upgrade the chaincode. Edit the install chaincode command above ***

   Go to **hyperledger ** folder  and then to **scripts** folder first from each organization (OSQO,BCP,ESP,BROKER) deployed machine using command:- 
 
`cd /hlf-volume/hyperledger/scripts`

**Note :- before upgrading the chaincode increment the version number to the next number from last deployed sequence number**

e.g.
Increment the version number parameter e.g.increasing version number to 2.0 (if previous was 1.0)

  

**For osqo deployed machine run the following command from scripts folder :**

  

`./chaincode/install-chaincode.sh osqo osqo-chaincode hlf-volume/hyperledger-chaincode/osqo-chaincode 2.0 1`

  

***Parameters here are :-

  

1. osqo is name of organization (1st parameter)

2. osqo-chaincode is name of chaincode (2nd parameter)

3. hlf-volume/hyperledger-chaincode/osqo-chaincode is path of chaincode (3rd parameter) 

4. 2.0 is the version of chaincode (4th parameter)

5. 1 is the incremented sequence number of chaincode (5th parameter)

  


**For bcp deployed machine run the following command from scripts folder :**

  

`./chaincode/install-chaincode.sh bcp osqo-chaincode hlf-volume/hyperledger-chaincode/osqo-chaincode 2.0 1`

  

***Parameters here are :-

  

1. bcp is name of organization (1st parameter)

2. osqo-chaincode is name of chaincode (2nd parameter)

3. hlf-volume/hyperledger-chaincode/osqo-chaincode is path of chaincode (3rd parameter) 

4. 2.0 is the version of chaincode (4th parameter)

5. 1 is the incremented sequence number of chaincode (5th parameter)





**For esp deployed machine run the following command from scripts folder :**

  

`./chaincode/install-chaincode.sh esp osqo-chaincode hlf-volume/hyperledger-chaincode/osqo-chaincode 2.0 1`

  

***Parameters here are :-

  

1. esp is name of organization (1st parameter)

2. osqo-chaincode is name of chaincode (2nd parameter)

3. hlf-volume/hyperledger-chaincode/osqo-chaincode is path of chaincode (3rd parameter) 

4. 2.0 is the version of chaincode (4th parameter)

5. 1 is the incremented sequence number of chaincode (5th parameter)



**For broker deployed machine run the following command from scripts folder :**

  

`./chaincode/install-chaincode.sh broker osqo-chaincode hlf-volume/hyperledger-chaincode/osqo-chaincode 2.0 1`

  

***Parameters here are :-

  

1. broker is name of organization (1st parameter)

2. osqo-chaincode is name of chaincode (2nd parameter)

3. hlf-volume/hyperledger-chaincode/osqo-chaincode is path of chaincode (3rd parameter) 

4. 2.0 is the version of chaincode (4th parameter)

5. 1 is the incremented sequence number of chaincode (5th parameter)



  

  **Note :- After installing new updgrade  on every organization , go to osqo deployed machine and commit the chaincode from scripts folder as well with new sequence number :-**

`./chaincode/commit-chaincode.sh osqo osqo-chaincode 2.0 1`




***Parameters here are :-

  

osqo is name of organization (1st parameter)

  

osqo-chaincode is name of chaincode (2nd parameter)

  

2.0 is the version of chaincode (3rd parameter)

  

1 is the incremented sequence number of chaincode (4th parameter)



## SDK-update

**Take the latest pull of SDK from Hyperledger-SDK repo in additional volume (hlf-volume) of every organization deployed machine with below command :- **


`git clone https://tejindermethodbridge@bitbucket.org/osqo/hyperledger-chaincode.git`


*** Restart the SDK container using command:-

`docker restart osqo-sdk`