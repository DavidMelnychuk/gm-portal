const hre = require("hardhat");

async function main() {
    // We get the contract to deploy
    const WavePortal = await hre.ethers.getContractFactory("WavePortal");
    const portal = await WavePortal.deploy();
      
    console.log("WavePortal deployed to:", portal.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });