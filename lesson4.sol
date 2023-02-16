// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface MyInterface{
    function helloWorld() external view returns (string memory);

    function potato() external;

    function setText(string calldata newText) external;

}

/// @title A simple implementation of Hello World
contract HelloWorld {
    string private text;

    constructor() {
        text = pureText();
    }

    function helloWorld() public view returns (string memory) {
        return text;
    }

    function setText(string calldata newText) public {
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

    fallback() external {
        text = "WRONG METHOD CALDED!";

    }



}


contract Greeter{
    constructor() payable{}

    function invokeFreting(address target) external view returns (string memory){
       return MyInterface(target).helloWorld();
       //return target.call(putthebyteshere); same as above
    }

    function modifyGreeting(address target, string calldata newText) external {
        MyInterface(target).setText(newText);
    }


    function invokeFallback(address target) external {
        MyInterface(target).potato();
    }
}







