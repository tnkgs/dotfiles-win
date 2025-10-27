#!/bin/bash

# Dotfiles installer script
# This script creates symbolic links from the dotfiles directory to the home directory

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to create symbolic link
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"
    
    if [ -L "$target" ]; then
        echo -e "${YELLOW}Removing existing symlink: $target${NC}"
        rm "$target"
    elif [ -e "$target" ]; then
        echo -e "${YELLOW}Backing up existing file: $target -> $target.backup${NC}"
        mv "$target" "$target.backup"
    fi
    
    echo -e "${GREEN}Creating symlink: $name${NC}"
    ln -s "$source" "$target"
}

# Function to install Powerlevel10k
install_powerlevel10k() {
    local P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    
    if [ -d "$P10K_DIR" ]; then
        echo -e "${YELLOW}Powerlevel10k already installed. Updating...${NC}"
        cd "$P10K_DIR" && git pull
    else
        echo -e "${GREEN}Installing Powerlevel10k...${NC}"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    fi
    
    echo -e "${GREEN}Powerlevel10k installation completed!${NC}"
    echo -e "${YELLOW}Run 'p10k configure' to configure Powerlevel10k after restarting your shell${NC}"
}

install_wsl2_ssh_agent() {
    echo -e "${GREEN}Installing WSL2 SSH Agent...${NC}"
    curl -L -O https://github.com/mame/wsl2-ssh-agent/releases/latest/download/wsl2-ssh-agent
    chmod 755 wsl2-ssh-agent
    mv wsl2-ssh-agent $HOME_DIR/.local/bin/wsl2-ssh-agent
    echo -e "${GREEN}WSL2 SSH Agent installation completed!${NC}"
}

# Function to install dotfiles
install_dotfiles() {
    echo -e "${GREEN}Installing dotfiles...${NC}"
    
    # Install Powerlevel10k theme
    if [ -d "$HOME/.oh-my-zsh" ]; then
        install_powerlevel10k
    else
        echo -e "${YELLOW}Oh My Zsh not found. Skipping Powerlevel10k installation.${NC}"
        echo -e "${YELLOW}Install Oh My Zsh first: https://ohmyz.sh/${NC}"
    fi

    # Create local bin directory
    if [ -d "$HOME_DIR/.local/bin" ]; then
        echo -e "${YELLOW}Local bin directory already exists. Skipping...${NC}"
    else
        mkdir -p "$HOME_DIR/.local/bin"  
    fi

    # Install WSL2 SSH Agent
    if [ -d "$HOME_DIR/.local/bin/wsl2-ssh-agent" ]; then
        echo -e "${GREEN}WSL2 SSH Agent already installed. Skipping...${NC}"
    else
        install_wsl2_ssh_agent
    fi

    echo ""
    echo -e "${GREEN}Installing dotfile symlinks...${NC}"
    
    # List of files to symlink (relative to dotfiles directory)
    files=(
        ".zshrc"
        ".bashrc"
        ".gitconfig"
        ".vimrc"
        ".tmux.conf"
        ".gitignore_global"
        ".p10k.zsh"
        "Microsoft.PowerShell_profile.ps1"
    )
    
    for file in "${files[@]}"; do
        source_file="$DOTFILES_DIR/$file"
        target_file="$HOME_DIR/$file"
        
        if [ -f "$source_file" ]; then
            create_symlink "$source_file" "$target_file" "$file"
        else
            echo -e "${YELLOW}File not found: $file (skipping)${NC}"
        fi
    done
    
    # Create directories for config files
    mkdir -p "$HOME_DIR/.config"
    
    # Install config files
    if [ -d "$DOTFILES_DIR/.config" ]; then
        for config_file in "$DOTFILES_DIR/.config"/*; do
            if [ -f "$config_file" ] || [ -d "$config_file" ]; then
                config_name=$(basename "$config_file")
                create_symlink "$config_file" "$HOME_DIR/.config/$config_name" ".config/$config_name"
            fi
        done
    fi
    
    echo -e "${GREEN}Dotfiles installation completed!${NC}"
    echo -e "${BLUE}Note: PowerShell profile requires separate installation${NC}"
    echo -e "${YELLOW}Run './install-powershell.sh install' to install PowerShell profile${NC}"
}

# Function to uninstall dotfiles
uninstall_dotfiles() {
    echo -e "${YELLOW}Uninstalling dotfiles...${NC}"
    
    files=(
        ".zshrc"
        ".bashrc"
        ".gitconfig"
        ".vimrc"
        ".tmux.conf"
        ".gitignore_global"
        ".p10k.zsh"
    )
    
    for file in "${files[@]}"; do
        target_file="$HOME_DIR/$file"
        if [ -L "$target_file" ]; then
            echo -e "${GREEN}Removing symlink: $file${NC}"
            rm "$target_file"
        fi
    done
    
    echo -e "${GREEN}Dotfiles uninstallation completed!${NC}"
}

# Main script
case "${1:-install}" in
    "install")
        install_dotfiles
        ;;
    "uninstall")
        uninstall_dotfiles
        ;;
    "help"|"-h"|"--help")
        echo "Usage: $0 [install|uninstall|help]"
        echo "  install   - Install dotfiles (default)"
        echo "  uninstall - Remove dotfile symlinks"
        echo "  help      - Show this help message"
        ;;
    *)
        echo -e "${RED}Unknown option: $1${NC}"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac