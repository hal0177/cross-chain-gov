// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";

contract VotesToken is ERC20, ERC20Votes {
    constructor() ERC20("VotesToken", "C3GOV") EIP712("VotesToken", "1.0.0") {}

    function mint(address _account, uint256 _amount) public {
        _mint(_account, _amount);
    }

    // overrides required by solidity

    function _update(address _from, address _to, uint256 _value) internal override(ERC20, ERC20Votes) {
        super._update(_from, _to, _value);
    }
}