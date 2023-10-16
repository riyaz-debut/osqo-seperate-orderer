## Network Architecture OSQO HLF  
  

We have five peer organizations and one ordering org in this network. All of the orgs are deployed on AWS.
####  Peer organizations
 - OSQO 
 - BCP 
 - ESP 
 - Broker 


#### AWS Servers
We have four instances hosting the all of above mentioned orgs.

 
| Instance | Private IP |	Public IP|	Region|
|--|--|--|--|
| HLF 1 | 172.31.16.180 |	54.252.142.45    | Sydeny
| HLF 2 | 172.31.29.208 |	3.27.44.202      | Sydeny
| HLF 3 | 172.31.18.250 |	13.236.135.224   | Sydney
  HLF 4  | 172.31.23.66  |	13.236.209.144   | Sydney


## HLF 1 nodes

peer0.osqo.osqo.com
peer1.osqo.osqo.com
orderer0.osqo.osqo.com


## HLF 2 nodes

peer0.bcp.osqo.com
peer1.bcp.osqo.com
orderer0.bcp.osqo.com


## HLF 3 nodes

peer0.esp.osqo.com
peer1.esp.osqo.com
orderer0.esp.osqo.com


## HLF 4 nodes

peer0.broker.osqo.com
peer1.broker.osqo.com
orderer0.broker.osqo.com



##### hosts entries

##### HLF 1 nodes (osqo)

54.252.142.45   peer0.osqo.osqo.com
54.252.142.45   peer1.osqo.osqo.com
54.252.142.45   orderer0.osqo.osqo.com  

##### HLF 2 nodes (bcp)

3.27.44.202   peer0.bcp.osqo.com
3.27.44.202   peer1.bcp.osqo.com
3.27.44.202   orderer0.bcp.osqo.com


##### HLF 3 nodes (esp)
13.236.135.224   peer0.esp.osqo.com    
13.236.135.224   peer1.esp.osqo.com
13.236.135.224   orderer0.esp.osqo.com

##### HLF 4 nodes (broker)
13.236.209.144   peer0.broker.osqo.com
13.236.209.144   peer1.broker.osqo.com
13.236.209.144   orderer0.broker.osqo.com



** Replace IP with localhost address on local hosted services for eg. replace ip for peer0.osqo.osqo.com with 127.0.0.1 on HLF 1 machine**
