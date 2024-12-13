#!/bin/bash

# Path to the node_pactus directory and pactus-wallet program
NODE_DIR="$HOME/node_pactus"
WALLET_CMD="./pactus-wallet"

# Navigate to the node_pactus directory
cd $NODE_DIR

# Command to get the list of addresses
ADDRESS_LIST=$($WALLET_CMD address all)

# Counter variable to track the validator number
validator_count=0

# Check each address
echo "Checking balances..."
echo "======================"

echo "$ADDRESS_LIST" | while read -r line; do
    # Extract address from each line
    address=$(echo "$line" | awk '{print $2}')
    
    # Skip if the address is not valid
    if [[ $address =~ ^pc1 ]]; then
        if [[ $validator_count -eq 0 ]]; then
            description="Reward address"
        else
            description="Validator address $validator_count"
        fi
        
        # Increment the validator count after processing
        validator_count=$((validator_count + 1))
        
        # Command to get the balance for each address
        balance=$($WALLET_CMD address balance "$address")
        
        # Display in the order you requested
        echo "Description: $description"
        echo "Address: $address"
        echo "Balance: $balance"
        echo "----------------------"
    fi
done
