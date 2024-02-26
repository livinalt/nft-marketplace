import { ethers } from "hardhat";

async function main() {
  const initialOwner = "0x92fF7b7a0D32CA77130eb71a2d50A1389f04A98b"; 

  // All deployement was done to sepolia
  // transaction hash Market place = 0x82f6d130c912a5ec00dc2d64d3251b65fcce34d79d7d345f67d70bf8ee697d48 // Market Place
  // Transaction hash NFT = 0x82f6d130c912a5ec00dc2d64d3251b65fcce34d79d7d345f67d70bf8ee697d48

  //  had trouble with an openzeppline version dependency

  // Deploy the NFT contract
  const MyWeb3 = await ethers.getContractFactory("MyWeb3");
  const myWeb3 = await MyWeb3.deploy(initialOwner);
  await myWeb3.deployed();

  // Deploy the marketplace contract
  const MyWeb3Market = await ethers.getContractFactory("MyWeb3Market");
  const myWeb3Market = await MyWeb3Market.deploy(initialOwner);
  await myWeb3Market.deployed();

  console.log(`NFT deployed to: ${myWeb3.address}`);
  console.log(`Marketplace deployed to: ${myWeb3Market.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode =  1;
});


