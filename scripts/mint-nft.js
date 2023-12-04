require("dotenv").config();
const ethers = require("ethers");

// Get Alchemy API Key
const API_KEY = process.env.API_KEY;

// Define an Alchemy Provider
const provider = new ethers.AlchemyProvider("sepolia", API_KEY);
const contract = require("../artifacts/contracts/MyNFT.sol/MyNFT.json");
// Create a signer
const privateKey = process.env.PRIVATE_KEY;
const signer = new ethers.Wallet(privateKey, provider);

// Get contract ABI and address
const abi = contract.abi;
const contractAddress = "0x80bF4c753cb9BF7d12d41ADfa21FD8F2c09D9393";

// Create a contract instance
const myNftContract = new ethers.Contract(contractAddress, abi, signer);
// Get the NFT Metadata IPFS URL
const tokenUri =
  "https://peach-wonderful-marlin-556.mypinata.cloud/ipfs/QmZ2ca5M4coR3GEg66K3dpVqf9TkvbFAiLFqWkjcGUnzBD";

// Call mintNFT function
const mintNFT = async () => {
  let nftTxn = await myNftContract.mintNFT(signer.address, tokenUri);
  await nftTxn.wait();
  console.log(
    `NFT Minted! Check it out at: https://sepolia.etherscan.io/tx/${nftTxn.hash}`
  );
};

mintNFT()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
