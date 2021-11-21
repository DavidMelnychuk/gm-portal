// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GMPortal {
    uint256 totalGMs;

    uint256 private seed;

    event NewGM(address indexed from, uint256 timestamp, string message);

    mapping(address => uint256) public addressToGms;
    mapping(address => uint256) public lastGmAt;

    struct GM {
        address user; // the address of the user who gm'd
        string message; // the message the use sent
        uint timestamp; // the timestamp when the user waved
    }

    GM[] GMs;
    
    constructor() payable {
        console.log("GM from Vancouver, WAGMI");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function gm(string memory _message) public {
       require(
            lastGmAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );        

        lastGmAt[msg.sender] = block.timestamp;
        
        totalGMs += 1;
        addressToGms[msg.sender] += 1;
        console.log("%s has gm'd! Number of times they've gm'd: %d", msg.sender, addressToGms[msg.sender]);
        
        GMs.push(GM(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("random num generated %d", seed);

        if(seed <= 50){
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewGM(msg.sender, block.timestamp, _message);
    }

    function getAllGMs() public view returns (GM[] memory){
        return GMs;
    }

    function getTotalGMs() public view returns (uint256){
        console.log("We have %d total gms!", totalGMs);
        return totalGMs;
    }
}
