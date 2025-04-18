# 🚀 Solana Dev Setup

This script sets up a full developer environment on a fresh **Ubuntu** or **WSL Ubuntu** instance. It installs and configures essential tools for blockchain and web development, including:

## 🔧 Tools Installed

- **Git** + SSH key setup
- **NVM** + latest **Node.js (LTS)**
- **Rust** + **Cargo**
- **Solana CLI** (via Agave installer)
- **Anchor CLI** (via AVM)
- Required build tools and dependencies

## 📦 Usage

```bash
bash solana-dev-setup.sh
```

Follow the prompts during execution:
- Enter your GitHub email for SSH key
- Copy and paste the SSH key into your GitHub account

## ✅ After Installation

You’ll have access to:
- `git`, `ssh`, `node`, `npm`
- `rustc`, `cargo`
- `solana`, `anchor`

Run `solana --version`, `anchor --version`, etc., to confirm setup.

---

**Note:** This works on **Ubuntu (native or WSL2)**. For macOS or other Linux distros, minor changes may be needed.

