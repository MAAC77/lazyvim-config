#!/bin/bash

# LazyVim Configuration Installation Script
# This script installs LazyVim with custom configurations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup-$(date +%Y%m%d-%H%M%S)"

echo "================================================"
echo "  LazyVim Custom Configuration Installer"
echo "================================================"
echo ""

# Detect package manager
detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v brew &> /dev/null; then
        echo "brew"
    else
        echo "unknown"
    fi
}

PKG_MANAGER=$(detect_package_manager)

# Install package based on package manager
install_package() {
    local package=$1
    local apt_name=${2:-$1}
    local pacman_name=${3:-$1}
    local dnf_name=${4:-$1}
    local brew_name=${5:-$1}

    echo "Installing $package..."
    case $PKG_MANAGER in
        apt)
            sudo apt update -qq && sudo apt install -y "$apt_name"
            ;;
        pacman)
            sudo pacman -S --noconfirm "$pacman_name"
            ;;
        dnf)
            sudo dnf install -y "$dnf_name"
            ;;
        brew)
            brew install "$brew_name"
            ;;
        *)
            echo "Unknown package manager. Please install $package manually."
            return 1
            ;;
    esac
}

# Install Neovim from tarball (Linux only)
install_neovim_tarball() {
    echo "Installing Neovim from official release..."

    local tmp_dir=$(mktemp -d)
    cd "$tmp_dir"

    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

    # Add to PATH if not already there
    if ! echo "$PATH" | grep -q "/opt/nvim-linux-x86_64/bin"; then
        echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> "$HOME/.bashrc"
        export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
        echo "Added Neovim to PATH in ~/.bashrc"
    fi

    cd - > /dev/null
    rm -rf "$tmp_dir"

    echo "Neovim installed successfully"
}

# Check and install Neovim
if ! command -v nvim &> /dev/null; then
    echo "Neovim is not installed. Installing..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        install_neovim_tarball
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            brew install neovim
        else
            echo "Please install Homebrew first: https://brew.sh"
            exit 1
        fi
    else
        echo "Unsupported OS. Please install Neovim manually."
        exit 1
    fi
fi

echo "Neovim found: $(nvim --version | head -n1)"
echo ""

# Check and install Git
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing..."
    install_package "git" "git" "git" "git" "git"
fi
echo "Git found"
echo ""

# Install dependencies
echo "Checking LazyVim dependencies..."
echo ""

# ripgrep (required for Telescope grep)
if ! command -v rg &> /dev/null; then
    echo "Installing ripgrep..."
    install_package "ripgrep" "ripgrep" "ripgrep" "ripgrep" "ripgrep" || echo "Please install ripgrep manually"
else
    echo "ripgrep found"
fi

# fd (required for Telescope find_files)
if ! command -v fd &> /dev/null && ! command -v fdfind &> /dev/null; then
    echo "Installing fd..."
    install_package "fd" "fd-find" "fd" "fd-find" "fd" || echo "Please install fd manually"
else
    echo "fd found"
fi

# Node.js via nvm (required for many LSP servers)
if ! command -v node &> /dev/null; then
    echo "Installing Node.js via nvm..."

    # Install nvm if not present
    if [ ! -d "$HOME/.nvm" ]; then
        echo "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    fi

    # Load nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Install LTS version
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'

    echo "Node.js LTS installed: $(node --version)"
else
    echo "Node.js found: $(node --version)"
fi

echo ""

# Rust and tree-sitter-cli (required for nvim-treesitter on systems with older glibc)
if ! command -v cargo &> /dev/null; then
    echo "Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo "Rust installed: $(rustc --version)"
else
    echo "Rust found: $(rustc --version)"
fi

# Install libclang (required to compile tree-sitter-cli)
echo "Installing libclang (required for tree-sitter-cli compilation)..."
case $PKG_MANAGER in
    apt)
        sudo apt update -qq && sudo apt install -y libclang-dev
        ;;
    pacman)
        sudo pacman -S --noconfirm clang
        ;;
    dnf)
        sudo dnf install -y clang-devel
        ;;
    brew)
        brew install llvm
        ;;
esac

# Install tree-sitter-cli via cargo (compiles from source, avoids glibc issues)
if ! command -v tree-sitter &> /dev/null; then
    echo "Installing tree-sitter-cli via cargo..."
    cargo install --locked tree-sitter-cli
    echo "tree-sitter-cli installed"
else
    echo "tree-sitter-cli found: $(tree-sitter --version)"
fi

echo ""

# Backup existing configuration
if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo "Existing Neovim configuration found"
    echo "Creating backup at: $BACKUP_DIR"
    cp -r "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
    echo "Backup created successfully"
    echo ""

    # Remove existing config
    echo "Removing old configuration..."
    rm -rf "$NVIM_CONFIG_DIR"
fi

# Create config directory
echo "Creating Neovim configuration directory..."
mkdir -p "$NVIM_CONFIG_DIR"

# Copy configuration files
echo "Copying configuration files..."
cp -r "$SCRIPT_DIR"/* "$NVIM_CONFIG_DIR/" 2>/dev/null || :

# Remove the install script and README from the config directory
rm -f "$NVIM_CONFIG_DIR/install.sh"
rm -f "$NVIM_CONFIG_DIR/README.md"

echo "Configuration files copied"
echo ""

echo "================================================"
echo "  Installation Complete!"
echo "================================================"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal (or run: source ~/.bashrc)"
echo "  2. Launch Neovim: nvim"
echo "  3. Wait for plugins to install automatically"
echo "  4. Restart Neovim"
echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo "Backup location: $BACKUP_DIR"
    echo ""
fi
