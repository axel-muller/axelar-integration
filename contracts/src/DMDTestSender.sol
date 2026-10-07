// SPDX-License-Identifier: MIT
pragma solidity 0.8.33;

interface IAxelarGateway {
    function callContract(
        string calldata destinationChain,
        string calldata destinationContractAddress,
        bytes calldata payload
    ) external;
}

contract DMDTestSender {
    IAxelarGateway public immutable gateway;

    event MessageSent(
        string destinationChain,
        string destinationContract,
        bytes payload
    );

    constructor(address gateway_) {
        gateway = IAxelarGateway(gateway_);
    }

    function sendMessage(
        string calldata destinationChain,
        string calldata destinationContract,
        string calldata message
    ) external {
        bytes memory payload = abi.encode(message);
        gateway.callContract(destinationChain, destinationContract, payload);

        emit MessageSent(destinationChain, destinationContract, payload);
    }
}
