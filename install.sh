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

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo "❌ Neovim is not installed!"
    echo ""
    echo "Please install Neovim first:"
    echo "  Ubuntu/Debian: sudo apt install neovim"
    echo "  Arch: sudo pacman -S neovim"
    echo "  macOS: brew install neovim"
    echo "  Or download from: https://github.com/neovim/neovim/releases"
    exit 1
fi

echo "✅ Neovim found: $(nvim --version | head -n1)"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed!"
    echo "Please install git first."
    exit 1
fi

echo "✅ Git found"
echo ""

# Backup existing configuration
if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo "📦 Existing Neovim configuration found"
    echo "   Creating backup at: $BACKUP_DIR"
    cp -r "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
    echo "✅ Backup created successfully"
    echo ""

    # Remove existing config
    echo "🗑️  Removing old configuration..."
    rm -rf "$NVIM_CONFIG_DIR"
fi

# Create config directory
echo "📁 Creating Neovim configuration directory..."
mkdir -p "$NVIM_CONFIG_DIR"

# Copy configuration files
echo "📋 Copying configuration files..."
cp -r "$SCRIPT_DIR"/* "$NVIM_CONFIG_DIR/" 2>/dev/null || :

# Remove the install script from the config directory
rm -f "$NVIM_CONFIG_DIR/install.sh"

echo "✅ Configuration files copied"
echo ""

# Check for Node.js (required for some LSP servers)
if command -v node &> /dev/null; then
    echo "✅ Node.js found: $(node --version)"
else
    echo "⚠️  Node.js not found (recommended for LSP servers)"
    echo "   Install from: https://nodejs.org/"
fi
echo ""

# Check for ripgrep (required for telescope)
if command -v rg &> /dev/null; then
    echo "✅ ripgrep found"
else
    echo "⚠️  ripgrep not found (required for Telescope)"
    echo "   Install with: sudo apt install ripgrep (or equivalent)"
fi
echo ""

# Check for fd (optional but recommended)
if command -v fd &> /dev/null; then
    echo "✅ fd found"
else
    echo "⚠️  fd not found (recommended for better file finding)"
    echo "   Install with: sudo apt install fd-find (or equivalent)"
fi
echo ""

echo "================================================"
echo "  Installation Complete!"
echo "================================================"
echo ""
echo "Next steps:"
echo "  1. Launch Neovim: nvim"
echo "  2. LazyVim will automatically install plugins on first run"
echo "  3. Wait for all plugins to finish installing"
echo "  4. Restart Neovim"
echo ""
echo "Available Claude Code shortcuts (in Neovim):"
echo "  <leader>ac  - Toggle Claude"
echo "  <leader>af  - Focus Claude"
echo "  <leader>ar  - Resume Claude"
echo "  <leader>ab  - Add current buffer"
echo "  <leader>aa  - Accept diff"
echo "  <leader>ad  - Deny diff"
echo ""
echo "Note: <leader> is usually the space key"
echo ""
echo "Backup location: $BACKUP_DIR"
echo ""
