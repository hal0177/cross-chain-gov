// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {VotesToken} from "../build/source/VotesToken.sol";
import {TimelockController} from "@openzeppelin/contracts/governance/TimelockController.sol";
import {MyGovernor} from "../build/source/MyGovernor.sol";
import {C3ProposalDispatch} from "../build/source/C3ProposalDispatch.sol";

contract DeploySrcChain is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy token
        // 2. Deploy timelock controller (dummy)
        // 3. Deploy Governor
        // 4. Deploy timelock controller (actual)
        // 5. Deploy C3ProposalDispatch
        // 6. Deploy Basic Names
        // 7. Initiate timelock with Governor
        // 8. Mint tokens

        address target = 0xADeE65208A9fd9d6d47AD2D8A53D7E019955d1Db;
        address c3CallerProxy = 0x433f3275a787be38703917fF2919CeFEAd9327cD;
        uint256 dappID = 6;
        address[] memory proposerAndExecutor =  new address[](1);

        // 1
        VotesToken votesToken = new VotesToken();

        // 2
        TimelockController timelockController = new TimelockController(5, proposerAndExecutor, proposerAndExecutor, address(0));

        // 3
        MyGovernor myGovernor = new MyGovernor(address(votesToken), address(timelockController));
        proposerAndExecutor[0] = address(myGovernor);

        // 4
        timelockController = new TimelockController(5, proposerAndExecutor, proposerAndExecutor, address(0));

        // 5
        C3ProposalDispatch c3ProposalDispatch = new C3ProposalDispatch(c3CallerProxy, dappID);

        // 6
        myGovernor.initializeTimelock(address(timelockController));

        // 7
        votesToken.mint(deployer, 10 ether);

        // 8
        // bytes memory targetChainData = abi.encodeWithSignature("addNameToWall(address,string)", deployer, "Jerome");
        // bytes memory payload = abi.encodePacked(target, targetChainData);
        // c3ProposalDispatch.receiveProposal(payload);

        vm.stopBroadcast();

        console.log("Token: ", address(votesToken));
        console.log("Timelock Controller: ", address(timelockController));
        console.log("Governor: ", address(myGovernor));
        console.log("C3ProposalDispatch: ", address(c3ProposalDispatch));
        console.log("User balance: ", votesToken.balanceOf(deployer));
    }
}