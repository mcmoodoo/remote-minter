## Remote Minter
The motivation behind this "app" is to demonstrate the ability to mint an NFT in a cross-chain fanction using [Chainlink's CCIP](https://docs.chain.link/ccip). In this case it was minting on Base via Arbitrum. Several smart contracts needed to be deployed to facilitate this process:
- Source Minter on Arbitrum
- Destination Minter on Base

A short [demo video]() demonstrates the entire process.

To try it yourself, clone this repo and run the script `minting.sh`. It might ask you to give it execution permissions `chmod a+x minting.sh`
