# Aviation Decentralized Supply Chain Application

This decentralization application (dapp) can be used to track the history of a used aviation engine part.  The origin starts from the shop removing the part and ends upon purchase from a buyer.  The shop removing the part hands it off to a store where further inspections and repairs are performed.  

![alt text][webapp]

[webapp]:https://github.com/mpUrban/Aviation_Decentralized_Supply_Chain/blob/master/images/webapp.png "Web App"









These UML diagrams detail the architecture of an application to track used part status and sales for the aviation industry. 

## Activity Diagram:
![alt text][activity]

## Sequence Diagram:
![alt text][sequence]

## State Diagram:
![alt text][state]

## Class Diagram:
![alt text][class]


[activity]:https://github.com/mpUrban/Aviation_Decentralized_Supply_Chain/blob/master/diagrams/activity2.png "Activity Diagram"

[sequence]:https://github.com/mpUrban/Aviation_Decentralized_Supply_Chain/blob/master/diagrams/sequence3.png "Activity Diagram"

[state]:https://github.com/mpUrban/Aviation_Decentralized_Supply_Chain/blob/master/diagrams/state1.png "Activity Diagram"

[class]:https://github.com/mpUrban/Aviation_Decentralized_Supply_Chain/blob/master/diagrams/class1.png "Activity Diagram"

# Running the application

First clone this repo to your local drive and install dependences as noted in the package.json folder.  

## Project Setup

Run the ganache test private blockchain:

```
ganache-cli -m "conduct shop dumb crash pretty movie gesture ski calm beach injury mixture"
```

Compile the smart contracts:

```
truffle compile
```

Deploy the smart contracts to the local test blockchain:

```
truffle deploy --network development
```

Unit test the smart contracts:

```
truffle test
```

The result of the tests should appear as:

![alt text][unittesting]

[unittesting]:https://github.com/mpUrban/Aviation_Decentralized_Supply_Chain/blob/master/images/unit_testing.png "Unit Testing"

To run the web application, from a new bash terminal:

```
npm run dev
```







## Rinkeby Testnet Deployment

These contracts are also deployed on the Ethereum Rinkeby testnet.  The contract address is 0x3B8Ea95011D4E859ce68E5Ed55692173AbdB5614.  

![alt text][rinkeby]

[rinkeby]:https://github.com/mpUrban/Aviation_Decentralized_Supply_Chain/blob/master/images/rinkeby_deployment.png