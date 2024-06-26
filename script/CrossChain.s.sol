// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {C3ProposalDispatch} from "../build/source/C3ProposalDispatch.sol";

contract CrossChainGov is Script {
    function run() public {
        address target = 0xF76e3696f15Bb55Bcd63e8ff2eCD3adA5B3Edb8f;
        C3ProposalDispatch c3ProposalDispatch = C3ProposalDispatch(0xf13f52085Fe8B8A0d2ebAf05d7cF4C63631E529A);

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // This would usually be called by Governor, however for the demo we are calling it directly
        bytes memory targetChainData = abi.encodeWithSignature("addName(address,string)", deployer, "Jerome");
        bytes memory payload = abi.encodePacked(target, targetChainData);
        c3ProposalDispatch.receiveProposal(payload);

        vm.stopBroadcast();
    }
}

// We add a name to a contract on another chain, using the C3Caller network to transmit the  message.

// This transaction is triggered on Arbitrum Sepolia.

// The contract state is updated as desired on BNB Testnet.