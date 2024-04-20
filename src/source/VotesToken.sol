// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract VotesToken is ERC20, ERC20Votes {
    constructor() ERC20("VotesToken", "VTKN") {}

    function mint(address _account, uint256 _amount) public {
        _mint(_account, _amount);
    }
}