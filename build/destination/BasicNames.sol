// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

// src/destination/BasicNames.sol

// This is the target contract on another chain. For our example, this contract adds an account's name
contract BasicNames {
    mapping(address => string) public names;

    event NameAdded(address _owner, string _name);

    function addName(address _owner, string memory _name) external {
        names[_owner] = _name;
    }
}
