// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract escrow{
    //declaring state variables (the players)

    address public depositor;
    address public beneficiary;
    address public arbiter;


    //you want to get the values right?
    constructor( address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    // throwing a custom error if the msg.sender is unauthorized
    error UnAuthorized();
    event Approved(uint);
    function approve() external{
        if(msg.sender != arbiter) revert UnAuthorized();
        uint balance = address(this).balance;
        (bool success, ) = beneficiary.call{value: balance}("");
        require (success);
        emit Approved(balance);
    }
}