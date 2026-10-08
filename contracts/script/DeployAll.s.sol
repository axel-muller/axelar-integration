// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.33;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {DMDTestReceiver} from "../src/DMDTestReceiver.sol";
import {DMDTestSender} from "../src/DMDTestSender.sol";

contract DeployAll is Script {
    mapping(uint256 => address) public gateways;

    function setUp() public {
        gateways[17771] = 0xAE64f45A541AaFc223B3D61D23e0F5c464438C16; // DMD Diamond
        gateways[43113] = 0xF128c84c3326727c3e155168daAa4C0156B87AD1; // Avalanche Fuji
    }

    function run() public {
        vm.startBroadcast();

        uint256 chainId = vm.getChainId();
        address gateway = gateways[chainId];

        address sender = _deploySender(gateway);
        address receiver = _deployReceiver(gateway);

        vm.stopBroadcast();

        console.log("Chain ID: ", chainId);
        console.log("Sender deployed at: ", sender);
        console.log("Receiver deployed at: ", receiver);
    }

    function _deploySender(address _gateway) private returns (address) {
        return address(new DMDTestSender(_gateway));
    }

    function _deployReceiver(address _gateway) private returns (address) {
        return address(new DMDTestReceiver(_gateway));
    }
}
