#!/bin/bash
set -e

# -------------------------
# WSL Ubuntu Dev Setup Script
# -------------------------
# Installs: Git + SSH, NVM + Node.js, Rust, Solana CLI, Anchor CLI

# Update System
sudo apt update && sudo apt upgrade -y

# Install Git and SSH
sudo apt install -y git openssh-client

# Configure SSH Key (manual step recommended)
echo "\n[!] Generating SSH key (skip if already exists)"
read -p "Enter your GitHub email: " github_email
ssh-keygen -t ed25519 -C "$github_email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
echo "\n[!] Your public SSH key is:"
cat ~/.ssh/id_ed25519.pub

# Install Curl
sudo apt install -y curl

# Install NVM and Node.js
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  echo "\n[+] Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts

# Install Rust
if ! command -v rustup &> /dev/null; then
  echo "\n[+] Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
source "$HOME/.cargo/env"

# Install Solana CLI (Agave Installer)
sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"
echo 'export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# Install build dependencies for Anchor
sudo apt install -y build-essential pkg-config libudev-dev libssl-dev libclang-dev llvm clang protobuf-compiler

# Install AVM (Anchor Version Manager)
cargo install --git https://github.com/coral-xyz/anchor avm --force

# Add Cargo bin to PATH
export PATH="$HOME/.cargo/bin:$PATH"
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc

# Install and use latest Anchor
avm install latest
avm use latest

# Done
solana --version
anchor --version
node -v
npm -v
rustc --version
cargo --version

echo "\n[✔] WSL Dev Environment Setup Complete"
echo "Paste your SSH key above into https://github.com/settings/keys"
