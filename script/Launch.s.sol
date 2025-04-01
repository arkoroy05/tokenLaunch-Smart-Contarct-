// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "forge-std/Script.sol";
import {LaunchPad} from "../src/Launch.sol";

contract LaunchPadScript is Script {
    function run() external {
        // Start broadcasting transactions
        vm.startBroadcast();

        // Deploy the LaunchPad contract
        LaunchPad launchPad = new LaunchPad();

        // Deploy a new Coin using the LaunchPad contract
        string memory name = "TestToken";
        string memory symbol = "TTK";
        uint256 amount = 1000 * 10 ** 18; // 1000 tokens with 18 decimals
        address deployedCoin = launchPad.deployCoin(name, symbol, amount);

        // Log the deployed Coin address
        console.log("Deployed Coin Address:", deployedCoin);

        // Fetch all deployed tokens
        address[] memory deployedTokens = launchPad.getDeployedTokens();
        console.log("Total Deployed Tokens:", deployedTokens.length);

        // Fetch tokens owned by the deployer
        address[] memory userTokens = launchPad.getUserTokens();
        console.log("User Tokens Count:", userTokens.length);

        // Fetch the total supply of the deployed token
        uint256 totalSupply = launchPad.totalSupply(deployedCoin);
        console.log("Total Supply of Deployed Coin:", totalSupply);

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}