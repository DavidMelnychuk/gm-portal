// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) public addressWaveCount;

    constructor() {
        console.log("gm from Vancouver, WAGMI");
    }

    function wave() public {
        totalWaves += 1;
        addressWaveCount[msg.sender] += 1;
        console.log("%s has waved! Number of times they've waved: %d", msg.sender, addressWaveCount[msg.sender]);
    }

    function getTotalWaves() public view returns (uint256){
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
