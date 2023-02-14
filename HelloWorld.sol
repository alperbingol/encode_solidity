// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface HelloWorldInterface {
    function helloWorld() external view returns (string memory);
    function setText(string memory newText) external;
}

/// @title A simple implementation of Hello World
contract HelloWorld is HelloWorldInterface {
    string private text;

    constructor() {
        text = "Hello World";
    }
    /// @notice This funtion returns the value of the state variable text that is stored at storage
    /// @dev The return value is copied to memory when the call is answered because the EVM can't return directly from storage
    function helloWorld() public view override returns (string memory)  {
        return text;
    }

    function setText(string memory newText) public override {
        text = newText;
    }
}




