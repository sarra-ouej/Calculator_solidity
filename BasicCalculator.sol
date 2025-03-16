// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract BasicCalculator{

    uint256 result = 0 ;
    function add(uint256 a , uint256 b ) internal {
        result = a + b ;
    }
    function subtract (uint256 a , uint256 b) internal {

        result =  a-b ;
    }
} 
contract AdvencedCalculator  is BasicCalculator{

    struct Operation{
        address user;
        string operationType;
        uint256 inputA;
        uint256 inputB;
        uint256 result;
        uint256 timestamp;
    }
    Operation[] public history;
    address public lastUser;

    function multiply (uint256 a , uint256 b) internal{
        result = a * b;
    }
    function divide( uint256 a , uint256 b ) internal {
        require(b != 0, "Cannot divide by zero");
        result =  a / b ;
    }


    mapping(address => uint256) private personalResults;
    mapping(address => uint256) public userOperationCount; 
    event OperationPerformed(
    address indexed user,
    string operationType,
    uint256 inputA,
    uint256 inputB,
    uint256 result,
    uint256 timestamp
);
    function performOperation (uint256 a , uint256 b , uint8 operation) external  {
        lastUser = msg.sender;
        string memory opName;


         if (operation == 0) {
        personalResults[msg.sender] = a + b;
            opName = "add";
        } else if (operation == 1) {
        personalResults[msg.sender] = a - b;
             opName = "subtract";

        } else if (operation == 2) {
        personalResults[msg.sender] = a * b;
            opName = "multiply";

        } else if (operation == 3) {
            divide(a, b);
             opName = "divide";

        } else {
            revert("Invalid operation");
        }
         history.push(Operation({
            user: msg.sender,
            operationType: opName,
            inputA: a,
            inputB: b,
            result: result,
            timestamp: block.timestamp
        }));
}
function getresult() public view  returns (uint256){
    return result;
}
function reset() external {
    result = 0;
}

}