// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

// This is the target contract on another chain. For our example, this contract adds an account's name
contract BasicNames {
    mapping(address => string) public names;

    event NameAdded(address _owner, string _name);

    error NamingFailed(address _owner, string _name);

    function addName(address _owner, string memory _name) external {
        // Create a pseudo 50% chance that it fails
        uint256 pseudoRandom = block.timestamp % 2;
        if (pseudoRandom > 0) {
            names[_owner] = _name;
        } else {
            revert NamingFailed(_owner, _name);
        }
    }
}