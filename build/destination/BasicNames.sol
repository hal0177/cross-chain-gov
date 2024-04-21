// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

// src/destination/BasicNames.sol

// This is the target contract on BNB Testnet. For our example, this contract saves an account's name.
contract BasicNames {
    mapping(address => string) public names;

    event NameAdded(address _owner, string _name);

    function addName(address _owner, string memory _name) external {
        names[_owner] = _name;
    }
}
