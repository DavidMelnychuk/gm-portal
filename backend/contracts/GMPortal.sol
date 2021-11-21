// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GMPortal {
    uint256 totalGMs;

    event NewGM(address indexed from, uint256 timestamp, string message);

    mapping(address => uint256) public addressToGms;

    struct GM {
        address user; // the address of the user who gm'd
        string message; // the message the use sent
        uint timestamp; // the timestamp when the user waved
    }

    GM[] GMs;
    
    constructor() {
        console.log("GM from Vancouver, WAGMI");
    }

    function gm(string memory _message) public {
        totalGMs += 1;
        addressToGms[msg.sender] += 1;
        console.log("%s has gm'd! Number of times they've gm'd: %d", msg.sender, addressToGms[msg.sender]);
        
        GMs.push(GM(msg.sender, _message, block.timestamp));
        emit NewGM(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getAllGMs() public view returns (GM[] memory){
        return GMs;
    }

    function getTotalGMs() public view returns (uint256){
        console.log("We have %d total gms!", totalGMs);
        return totalGMs;
    }
}
