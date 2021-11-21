const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const gmContractFactory = await hre.ethers.getContractFactory('GMPortal');
    const gmContract = await gmContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
    });
    await gmContract.deployed();
    console.log("Contract deployed to:", gmContract.address);
    console.log("Contract deployed by:", owner.address);

    let contractBalance = await hre.ethers.provider.getBalance(
        gmContract.address
    );

    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
      );


    let gmTxn = await gmContract.gm("A message!");
    await gmTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(gmContract.address);
    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
    );

    let allGMs = await gmContract.getAllGMs();
    console.log(allGMs);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();