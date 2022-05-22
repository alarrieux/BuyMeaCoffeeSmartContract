// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract CoffeePortal {
    uint256 totalCoffee;

    address payable public owner;

    // Below we create an event which emits the stored arguments to transaction logs
    //logs are stored on the blockchain and are accessible using the address of the contract
    // we collect the arguments of from to address, the time, message, and name
    event NewCoffee(
       address indexed from, 
       uint256 timestamp,
       string message,
       string name 
    );

    constructor() payable {
        console.log("Hello World!");

        //below we create a varibale to capture the user calling the function
        owner = payable(msg.sender);
    }

    //Below we create a custom datatype, struct, that we can customize to hold what we want inside

    struct Coffee {
        address giver;
        string message;
        string name;
        uint256 timestamp;
    }

    //We create an empty array that will hold store the details from the structs
    //This is what lets me hold all the coffee anyone ever sends to me;
    Coffee[] coffee;

    /*
    *Below we return the coffee struct array this will make it easier
    *to retrieve the coffee from the website!
    */
    
    function getAllCoffee() public view returns(Coffee[] memory) {
        return coffee;
    }


    //Get all coffee bought
    function getTotalCoffee() public view returns (uint256) {
        console.log("We have %d total coffee received ", totalCoffee);
        return totalCoffee;
    }

    function buyCoffee(
        string memory _message,
        string memory _name,
        uint256 _payAmount
    ) public payable {
        uint256 cost = 0.001 ether;
        require(_payAmount <= cost, "Insufficient Ether provided");

        totalCoffee += 1;
        console.log("%s has just sent a coffee!", msg.sender);

        //Below we store the transaction into the Coffee array
        coffee.push(Coffee(msg.sender, _message, _name, block.timestamp));

        (bool success, ) = owner.call{value:_payAmount} ("");
        require(success, "Failed to send money");

        emit NewCoffee(msg.sender, block.timestamp, _message, _name);
    }
}