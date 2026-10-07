// SPDX-License-Identifier: MIT
pragma solidity 0.8.33;

import {AxelarExecutable} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/executable/AxelarExecutable.sol";

contract DMDTestReceiver is AxelarExecutable {
    bytes32 public lastCommandId;
    string public lastSourceChain;
    string public lastSourceAddress;
    string public lastMessage;

    event MessageReceived(bytes32 indexed commandId, string sourceChain, string sourceAddress, string message);

    constructor(address gateway_) AxelarExecutable(gateway_) {}

    function _execute(
        bytes32 commandId,
        string calldata sourceChain,
        string calldata sourceAddress,
        bytes calldata payload
    ) internal override {
        string memory message = abi.decode(payload, (string));

        lastCommandId = commandId;
        lastSourceChain = sourceChain;
        lastSourceAddress = sourceAddress;
        lastMessage = message;

        emit MessageReceived(commandId, sourceChain, sourceAddress, message);
    }
}
