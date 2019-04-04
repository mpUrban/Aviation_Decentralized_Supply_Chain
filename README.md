# Aviation Decentralized Supply Chain Application

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