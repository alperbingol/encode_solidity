// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;



/// @title A simple implementation of Hello World
contract HelloWorld {
    string private text;

    constructor() {
        text = pureText();
    }

    function helloWorld() public view returns (string memory) {
        return text;
    }

    function setText(string memory newText) public {
        text = newText;
    }

    function pureText() public pure virtual returns (string memory) {
        return "Hello World!";
    }

    function _isPure() internal view returns (bool check_) {
        check_ = keccak256(bytes(text)) == keccak256(bytes(pureText()));
    }

    function isPure() public view returns (bool returnValue_) {
        returnValue_ = _isPure();
    }

    function _restore() internal {
        text = pureText();
    }
    /*
    function restore() public returns (bool) {
        if (_isPure()) return false; //try to avoid spend money otherwise restore will do nothing after first call
        _restore();
        return true;
    }
    */

    modifier onlyWhenNotPureText(){
         require(!isPure(),"the value of text is already equal to return value of pureText");
         _; //basta sonda olmasi onemli
         //it just specifies a point when the actual function will be run - either before or after require in the modifier


    }

    function restore() public onlyWhenNotPureText(){
        _restore();
    }

    function sample() external payable returns (uint) {
        return msg.value;
    }


}


contract HelloWorldA is HelloWorld {
    function pureText() public pure override returns (string memory) {
        return "Hello There!";
    }
}

contract HelloWorldB is HelloWorld {
    function pureText() public pure override returns (string memory) {
        return "General Kenobi!";
    }
}
