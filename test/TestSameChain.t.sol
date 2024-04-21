// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import {TimelockController} from "@openzeppelin/contracts/governance/TimelockController.sol";
import {VotesToken} from "../build/source/VotesToken.sol";
import {MyGovernor} from "../build/source/MyGovernor.sol";
import {C3ProposalDispatch} from "../build/source/C3ProposalDispatch.sol";

import {NameWall} from "../build/destination/NameWall.sol";

contract TestSameChain is Test {
    VotesToken votesToken;
    MyGovernor myGovernor;
    TimelockController timelockController;
    C3ProposalDispatch c3ProposalDispatch;
    NameWall nameWall;
    string constant MNEMONIC = "test test test test test test test test test test test junk";
    address user;

    address c3callerProxy = 0x433f3275a787be38703917fF2919CeFEAd9327cD;
    uint256 dappID = 0;

    function setUp() public {
        uint256 privKey = vm.deriveKey(MNEMONIC, 1);
        user = vm.addr(privKey);

        address[] memory proposerExecutor = new address[](1);

        // DEPLOY
        timelockController = new TimelockController(5, proposerExecutor, proposerExecutor, address(0));
        // DEPLOY
        votesToken = new VotesToken();
        // DEPLOY
        myGovernor = new MyGovernor(address(votesToken), address(timelockController));
        proposerExecutor[0] = address(myGovernor);
        // DEPLOY
        timelockController = new TimelockController(5, proposerExecutor, proposerExecutor, address(0));
        // DEPLOY
        c3ProposalDispatch = new C3ProposalDispatch(c3callerProxy, dappID);
        // DEPLOY
        nameWall = new NameWall();

        // TX
        myGovernor.initializeTimelock(address(timelockController));

        // TX
        votesToken.mint(user, 10 ether);
    }

    function test_CrossChain() public {
        vm.startPrank(user);

        bytes memory targetChainData = abi.encodeWithSignature("addNameToWall(address,string)", user, "Jamie");
        // address[] memory targets = new address[](1);
        // uint256[] memory values = new uint256[](1);
        // bytes[] memory payloads = new bytes[](1);
        // targets[0] = address(c3ProposalDispatch);
        // values[0] = 0;
        // payloads[0] = abi.encodeWithSignature("receiveProposal(bytes)", targetChainData);
        // string memory descriptionHash = "Proposal #1: Write my name on BNB Testnet.";
        // uint256 proposalId = myGovernor.propose(targets, values, payloads, descriptionHash);
        // skip(10);
        // myGovernor.castVote(proposalId, 1);
        // skip(10);
        // myGovernor.queue(targets, values, payloads, keccak256(bytes(descriptionHash)));
        // skip(5);
        // myGovernor.execute(targets, values, payloads, keccak256(bytes(descriptionHash)));

        //  /\  Above: Typical scenario where one must wait for Governor vote to pass.
        //  ||
        //  \/  Below: Directly calling the receiveProposal function on C3ProposalDispatch (for demo purposes).

        address target = address(nameWall);
        c3ProposalDispatch.receiveProposal(target, targetChainData);
        string memory added = nameWall.wall(user);
        console.log(added);

        vm.stopPrank();
    }
}