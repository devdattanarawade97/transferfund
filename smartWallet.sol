// SPDX-License-Identifier: MIT

//compiler version
pragma solidity 0.8.0;

//test contract
contract Test {
    //wallet balance
    uint256 balance;

    //deposit to this contract
    function deposit() public payable {
        balance = balance + msg.value;
    }

    //events
    event transactionLogs(address, string);

    //@notice - transfer fund
    function transferFund(
        address payable customerAddress,
        bytes calldata payload
    ) external payable {
        (bool status, ) = customerAddress.delegatecall(payload);
        require(status, "failed");
        emit transactionLogs(customerAddress, "transaction successful");
    }
}

//@title - depositing money from others contract to my contract
//@author - -devdatta
//@dev -all functions are working without error

contract devdattaContract {
    //event
    event transactionLogs(address, string);

    //@notice - to make this contract payable
    receive() external payable {
        emit transactionLogs(msg.sender, "transaction successfull");
    }

    //@notice - deposits money to this contract
    function depositMoney(address payable customerAddress) external payable {
        payable(customerAddress).transfer(address(this).balance);
    }

    //@notice- get contract balance
    //@return- the contract balance
    function contractBalance() public view returns (uint256 balance) {
        balance = address(this).balance;
    }
}
