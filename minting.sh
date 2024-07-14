echo "Trying to retrieve your private key from the Foundry's local keystore"
cast wallet decrypt-keystore rashid-test-wallet 

read -sp "Enter your private key (secretly): " private_key
echo

# Deploying the DestinationMinter on Base Sepolia
forge script ./script/CrossChainNFT.s.sol:DeployDestination -vvv --broadcast --rpc-url baseGoerli --sig "run(uint8)" -- 6
read -p "Enter the address of the DestinationMinter: " destination_minter_address # 0xFc740263b97Da219c091D6e50A5d6e3fd9b90B2c

# Deploying the SourceMinter on Arbitrum Sepolia
forge script ./script/CrossChainNFT.s.sol:DeploySource -vvv --broadcast --rpc-url arbitrumSepolia --sig "run(uint8)" -- 2

# Fund the SourceMinter smart contract with eth
read -p "Enter the address of the SourceMinter: " source_minter_address # 0xbcfbd210A68F2296d3ba1506f5705768820fF68E
cast send $source_minter_address --rpc-url arbitrumSepolia --value 0.003ether --private-key=$PRIVATE_KEY

# Mint the NFT on Base Sepolia from Arbitrum Sepolia
forge script ./script/CrossChainNFT.s.sol:Mint -vvv --broadcast --rpc-url arbitrumSepolia --sig "run(address,uint8,address,uint8)" -- $source_minter_address 6 $destination_minter_address 0

# If everything went well, let's verify your NFT
#read -p "Enter your new NFT's address: " nft_address 
#read -p "Enter your EOA address: " eoa_address 
#cast call $nft_address "balanceOf(address)" $eoa_address --rpc-url baseSepolia
#cast call 0x40F20078F099E60D2b0F497FA5FEd0Be29D8e1D9 "balanceOf(address)" 0x338A3Ec604dB552d9B68391E88E7B1d8408b3Ae1 --rpc-url https://sepolia.base.org