// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

import "@c3caller/protocol/C3CallerDapp.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract C3ProposalDispatch is C3CallerDapp {
    using Strings for *;

    uint256 constant DEST_CHAIN_ID = 97; // BNB Testnet
    bytes4 constant ADD_NAME = bytes4(keccak256("addName(address,string)"));

    constructor(address _c3CallerProxy, uint256 _dappID) C3CallerDapp(_c3CallerProxy, _dappID) {}

    // In production, this would be onlyGovernor.
    function receiveProposal(bytes memory _execData) external {
        (address _target, bytes memory _data) = abi.decode(_execData, (address, bytes));
        _dispatchProposal(_target, _data);
    }

    function _dispatchProposal(address _target, bytes memory _data) internal {
        c3call(_target.toHexString(), DEST_CHAIN_ID.toString(), _data);
        // (bool success, bytes memory result) = _target.call(_data);
    }

    // Handle the failed tx
    function _c3Fallback(
        bytes4 _selector,
        bytes calldata _data,
        bytes calldata _reason
    ) internal pure override returns (bool) {
        return bool(_selector == ADD_NAME);
    }

    // This would be onlyGovernor in production
    function setC3CallerProxy(address _proxy) external {
        c3CallerProxy = _proxy;
    }
}