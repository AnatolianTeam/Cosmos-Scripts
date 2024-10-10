#!/bin/bash

curl -s https://github.com/AnatolianTeam/Cosmos-Scripts/main/utils/logo.sh | bash
sleep 5

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
PINK='\033[1;35m'

show() {
    case $2 in
        "error")
            echo -e "${PINK}${BOLD}❌ $1${NORMAL}"
            ;;
        "progress")
            echo -e "${PINK}${BOLD}⏳ $1${NORMAL}"
            ;;
        *)
            echo -e "${PINK}${BOLD}✅ $1${NORMAL}"
            ;;
    esac
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit

read -p "Cüzdan Private Keyiniz: " PRIVATE_KEY
read -p "Token ismi giriniz (e.g., Anatolian Token): " TOKEN_NAME
read -p "Token sembolü giriniz (e.g., ANT): " TOKEN_SYMBOL
read -p "Kontrat ismi giriniz (örn., Anatolian): " CONTRACT_NAME

mkdir -p "$SCRIPT_DIR/token_deployment"
cat <<EOL > "$SCRIPT_DIR/token_deployment/.env"
PRIVATE_KEY="$PRIVATE_KEY"
TOKEN_NAME="$TOKEN_NAME"
TOKEN_SYMBOL="$TOKEN_SYMBOL"
CONTRACT_NAME="$CONTRACT_NAME"
EOL

source "$SCRIPT_DIR/token_deployment/.env"


if [ ! -d ".git" ]; then
    show "Git deposu başlatılıyor..." "progress"
    git init
fi

if ! command -v forge &> /dev/null; then
    show "Foundry yüklü değil. Şimdi yükleniyor..." "progress"
    source <(wget -O - https://raw.githubusercontent.com/zunxbt/installation/main/foundry.sh)
fi

if [ ! -d "$SCRIPT_DIR/lib/openzeppelin-contracts" ]; then
    show "OpenZeppelin Kontratları yükleniyor..." "progress"
    git clone https://github.com/OpenZeppelin/openzeppelin-contracts.git "$SCRIPT_DIR/lib/openzeppelin-contracts"
else
    show "OpenZeppelin Kontratları yüklü."
fi

if [ ! -f "$SCRIPT_DIR/foundry.toml" ]; then
    show "Creating foundry.toml and adding Unichain RPC..." "progress"
    cat <<EOL > "$SCRIPT_DIR/foundry.toml"
[profile.default]
src = "src"
out = "out"
libs = ["lib"]

[rpc_endpoints]
unichain = "https://sepolia.unichain.org"
EOL
else
    show "foundry.toml dosyası mevcut."
fi

show "OpenZeppelin ile ERC-20 token kontratı oluşturuluyor..." "progress"
mkdir -p "$SCRIPT_DIR/src"
cat <<EOL > "$SCRIPT_DIR/src/$CONTRACT_NAME.sol"
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract $CONTRACT_NAME is ERC20 {
    constructor() ERC20("$TOKEN_NAME", "$TOKEN_SYMBOL") {
        _mint(msg.sender, 100000 * (10 ** decimals()));
    }
}
EOL

show "Kontrat derleniyor..." "progress"
forge build

if [[ $? -ne 0 ]]; then
    show "Kontrat derlemesi başarısız oldu." "error"
    exit 1
fi

show "Kontrat Unichain ağında deploy yayınlanıyor..." "progress"
DEPLOY_OUTPUT=$(forge create "$SCRIPT_DIR/src/$CONTRACT_NAME.sol:$CONTRACT_NAME" \
    --rpc-url unichain \
    --private-key "$PRIVATE_KEY")

if [[ $? -ne 0 ]]; then
    show "Deploy işlemi başarısız oldu" "error"
    exit 1
fi


CONTRACT_ADDRESS=$(echo "$DEPLOY_OUTPUT" | grep -oP 'Kontrat burada yayınlandı: \K(0x[a-fA-F0-9]{40})')
show "Token bu adreste başarıyla yayınlandı: https://sepolia.uniscan.xyz/address/$CONTRACT_ADDRESS"
