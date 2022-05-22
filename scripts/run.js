const main = async() => {

    //This will compile our contract and generate the necessary files 
    const coffeeContractFactory = await hre.ethers.getContractFactory('CoffeePortal');

    const coffeeContract = await coffeeContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    });
 
    await coffeeContract.deployed();  
        console.log("Coffee Contract deployed to:", coffeeContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(
        coffeeContract.address
    );

    console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );

    const coffeeTxn = await coffeeContract.buyCoffee(
        "This is coffee 100000",
        "Ashley",
        ethers.utils.parseEther("0.001")
    );
    await coffeeTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(
        coffeeContract.address
    );
    console.log(
        "Contract balance",
        hre.ethers.utils.formatEther(contractBalance)
    );

    let allCoffee = await coffeeContract.getAllCoffee();
    console.log(allCoffee);
};



const runMain = async () => {
    try{
        await main();
        process.exit(0)
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();