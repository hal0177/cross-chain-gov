// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../build/destination/BasicNames.sol";

contract DeployDestChain is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy Basic Names

        // 1
        BasicNames basicNames = new BasicNames();

        vm.stopBroadcast();

        console.log("Basic Names: ", address(basicNames));
        console.log("ETH Balance: ", deployer.balance);
    }
}