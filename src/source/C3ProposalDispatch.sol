// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

import "@c3caller/protocol/C3CallerDapp.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract C3ProposalDispatch is C3CallerDapp {
    using Strings for *;

    uint256 constant DEST_CHAIN_ID = 97; // BNB Testnet

    mapping(bytes32 => bool) public received;

    constructor(address _c3CallerProxy, uint256 _dappID) C3CallerDapp(_c3CallerProxy, _dappID) {}

    function receiveProposal(address _target, bytes memory _execData) external {
        bytes32 proposalHash = keccak256(abi.encodePacked(_target, _execData));
        received[proposalHash] = true;
        _dispatchProposal(_target, _execData);
    }

    function _dispatchProposal(address target, bytes memory data) internal {
        // c3call(target.toHexString(), DEST_CHAIN_ID.toString(), data);
        (bool success, bytes memory result) = target.call(data);
    }

    function _c3Fallback(bytes4 _selector, bytes calldata _data, bytes calldata _reason) internal override returns (bool) {
        // fallback
        //
    }

    function setC3CallerProxy(address _proxy) external {
        c3CallerProxy = _proxy;
    }
}