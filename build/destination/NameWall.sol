// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

// src/destination/NameWall.sol

// This is the target contract on another chain. For our example, this contract increases a number by 1
contract NameWall {
    mapping(address => string) public wall;

    event NameAdded(address _owner, string _name);

    error NameRejected(address _owner, string _name);

    function addNameToWall(address _owner, string memory _name) external {
        // Create a pseudo 50% chance that it fails
        uint256 pseudoRandom = block.timestamp % 2;
        if (pseudoRandom > 0) {
            wall[_owner] = _name;
        } else {
            revert NameRejected(_owner, _name);
        }
    }
}
