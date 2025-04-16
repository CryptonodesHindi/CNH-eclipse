#!/bin/bash

# Define color codes
INFO='\033[0;36m'  # Cyan
BANNER='\033[0;35m' # Magenta
YELLOW='\033[0;33m' # Yellow
RED='\033[0;31m'    # Red
GREEN='\033[0;32m'  # Green
BLUE='\033[0;34m'   # Blue
NC='\033[0m'        # No Color

# Display social details and channel information in large letters manually
echo "========================================"
echo -e "${YELLOW} Script is made by CRYPTONODEHINDI${NC}"
echo -e "-------------------------------------"

echo -e ""
echo -e ""
echo -e '\e[34m'
echo " ██████╗██████╗ ██╗   ██╗██████╗ ████████╗ ██████╗     ███╗   ██╗ ██████╗ ██████╗ ███████╗    ██╗  ██╗██╗███╗   ██╗██████╗ ██╗"
echo "██╔════╝██╔══██╗╚██╗ ██╔╝██╔══██╗╚══██╔══╝██╔═══██╗    ████╗  ██║██╔═══██╗██╔══██╗██╔════╝    ██║  ██║██║████╗  ██║██╔══██╗██║"
echo "██║     ██████╔╝ ╚████╔╝ ██████╔╝   ██║   ██║   ██║    ██╔██╗ ██║██║   ██║██║  ██║█████╗      ███████║██║██╔██╗ ██║██║  ██║██║"
echo "██║     ██╔══██╗  ╚██╔╝  ██╔═══╝    ██║   ██║   ██║    ██║╚██╗██║██║   ██║██║  ██║██╔══╝      ██╔══██║██║██║╚██╗██║██║  ██║██║"
echo "╚██████╗██║  ██║   ██║   ██║        ██║   ╚██████╔╝    ██║ ╚████║╚██████╔╝██████╔╝███████╗    ██║  ██║██║██║ ╚████║██████╔╝██║"
echo " ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝        ╚═╝    ╚═════╝     ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝     ╚═╝    ╚═╝  ╚═╝╚═╚═╝   ╚═══╝╚═════╝ ╚═╝"
 
echo "======================================================="

echo -e "${YELLOW}Telegram: ${GREEN}https://t.me/cryptonodehindi${NC}"
echo -e "${YELLOW}Twitter: ${GREEN}@CryptonodeHindi${NC}"
echo -e "${YELLOW}YouTube: ${GREEN}https://www.youtube.com/@CryptonodesHindi${NC}"
echo -e "${YELLOW}Medium: ${CYAN}https://medium.com/@cryptonodehindi${NC}"
echo "======================================================="

#Update the package 
sudo apt update -y

# 1️⃣ Password input variable
read -s -p "Enter your Solana wallet password (for keypair generation): " password
echo ""

# 2️⃣ Install Rust
echo "🛠️ Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# 3️⃣ Install Solana CLI
echo "🛠️ Installing Solana CLI..."
curl --proto '=https' --tlsv1.2 -sSfL https://solana-install.solana.workers.dev | bash
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# 4️⃣ Install expect (if not exists)
if ! command -v expect &>/dev/null; then
  echo "🔧 expect not found, installing..."
  sudo apt update && sudo apt install -y expect
else
  echo "✅ expect already installed"
fi

# 5️⃣ Auto-generate keypair with password
mkdir -p "$HOME/.config/solana"

expect <<EOF
spawn solana-keygen new --force
expect "Enter same passphrase again:"
send "$password\r"
expect "Enter same passphrase again:"
send "$password\r"
expect eof
EOF

# 6️⃣ Output private key
echo ""
echo "✅ Your Solana private key has been generated below. Please copy and import to Backpack wallet:"
echo ""
cat $HOME/.config/solana/id.json
echo ""
echo "⚠️ This is an array-formatted private key. Please store it securely before importing to bp wallet"

# 7️⃣ Confirmation prompt (default y)
read -p "Have you sent 0.005 ETH to this wallet on Eclipse network? [Y/n]: " confirm
confirm=${confirm:-y}

if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo "🚀 Starting bitz installation and deployment..."

  # Install bitz
  cargo install bitz

  # Set RPC endpoint
  solana config set --url https://eclipse.helius-rpc.com/
fi

 # Display thank you message
echo "========================================"
echo -e "${YELLOW} Thanks for using the script${NC}"
echo -e "-------------------------------------"