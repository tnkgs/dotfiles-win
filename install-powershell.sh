#!/bin/bash

# PowerShell Profile installer script for WSL environment
# This script creates symbolic links from the dotfiles directory to Windows PowerShell profile location
#
# Features:
# - Calls install-powershell.ps1 from WSL
# - Installs PowerShell profile + modules (Terminal-Icons, posh-git)
# - Auto-installs Moralerspace HWJPDOC font (Japanese programming font)
# - Validates PowerShell installation
# - Syntax checking
#
# Prerequisites (manual installation):
# - Oh My Posh: winget install JanDeDobbeleer.OhMyPosh
#
# Recommended font setting:
# - 'Moralerspace Argon HWJPDOC', 'Consolas', monospace

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

convert_windows_path_to_wsl() {
    local win_path="$1"

    if [ -z "$win_path" ]; then
        return 1
    fi

    local drive_letter="${win_path:0:1}"
    local remainder="${win_path:2}"

    remainder="${remainder//\\//}"
    remainder="${remainder#/}"

    printf '/mnt/%s/%s\n' "$(echo "$drive_letter" | tr 'A-Z' 'a-z')" "$remainder"
}

get_windows_dotfiles_path() {
    local win_profile
    win_profile=$(cmd.exe /c echo %USERPROFILE% 2>/dev/null | tr -d '\r')
    if [ -z "$win_profile" ]; then
        return 1
    fi

    local unix_profile
    unix_profile=$(convert_windows_path_to_wsl "$win_profile") || return 1
    printf '%s/dotfiles\n' "$unix_profile"
}

WINDOWS_DOTFILES="$(get_windows_dotfiles_path)"
if [ -z "$WINDOWS_DOTFILES" ]; then
    echo -e "${RED}Failed to determine Windows user profile path.${NC}"
    exit 1
fi

# Function to install PowerShell profile
install_powershell_profile() {
    echo -e "${GREEN}Installing PowerShell profile...${NC}"
    
    local windows_dotfiles="$WINDOWS_DOTFILES"
    local ps_script="$windows_dotfiles/install-powershell.ps1"
    
    if [ -f "$ps_script" ]; then
        echo -e "${BLUE}Running PowerShell installer script from Windows directory...${NC}"
        cd "$windows_dotfiles" && pwsh.exe -File "install-powershell.ps1" -Action install
    else
        echo -e "${RED}PowerShell installer script not found: $ps_script${NC}"
        exit 1
    fi
}

# Function to uninstall PowerShell profile
uninstall_powershell_profile() {
    echo -e "${YELLOW}Uninstalling PowerShell profile...${NC}"
    
    local windows_dotfiles="$WINDOWS_DOTFILES"
    local ps_script="$windows_dotfiles/install-powershell.ps1"
    
    if [ -f "$ps_script" ]; then
        echo -e "${BLUE}Running PowerShell uninstaller script from Windows directory...${NC}"
        cd "$windows_dotfiles" && pwsh.exe -File "install-powershell.ps1" -Action uninstall
    else
        echo -e "${RED}PowerShell installer script not found: $ps_script${NC}"
        exit 1
    fi
}

# Function to check PowerShell installation
check_powershell() {
    echo -e "${BLUE}Checking PowerShell installation...${NC}"
    
    if command -v pwsh.exe >/dev/null 2>&1; then
        local version=$(pwsh.exe --version 2>/dev/null || echo "Unknown")
        echo -e "${GREEN}PowerShell found: $version${NC}"
        return 0
    else
        echo -e "${RED}PowerShell not found. Please install PowerShell Core.${NC}"
        echo -e "${YELLOW}Download from: https://github.com/PowerShell/PowerShell/releases${NC}"
        return 1
    fi
}

# Function to test PowerShell profile
test_powershell_profile() {
    echo -e "${BLUE}Testing PowerShell profile...${NC}"
    
    local windows_dotfiles="$WINDOWS_DOTFILES"
    local ps_script="$windows_dotfiles/install-powershell.ps1"
    
    if [ -f "$ps_script" ]; then
        echo -e "${BLUE}Running PowerShell test script from Windows directory...${NC}"
        cd "$windows_dotfiles" && pwsh.exe -File "install-powershell.ps1" -Action test
    else
        echo -e "${RED}PowerShell installer script not found: $ps_script${NC}"
        exit 1
    fi
}

# Function to install font only
install_font_only() {
    echo -e "${BLUE}Installing Moralerspace HWJPDOC font...${NC}"
    
    local windows_dotfiles="$WINDOWS_DOTFILES"
    local ps_script="$windows_dotfiles/install-powershell.ps1"
    
    if [ -f "$ps_script" ]; then
        echo -e "${BLUE}Running font installer from Windows directory...${NC}"
        cd "$windows_dotfiles" && pwsh.exe -File "install-powershell.ps1" -Action font
    else
        echo -e "${RED}PowerShell installer script not found: $ps_script${NC}"
        exit 1
    fi
}

# Main script
case "${1:-install}" in
    "install")
        if check_powershell; then
            install_powershell_profile
        else
            exit 1
        fi
        ;;
    "uninstall")
        uninstall_powershell_profile
        ;;
    "test")
        test_powershell_profile
        ;;
    "check")
        check_powershell
        ;;
    "font")
        install_font_only
        ;;
    "help"|"-h"|"--help")
        echo -e "${BLUE}PowerShell Profile Installer (WSL Wrapper)${NC}"
        echo -e "${BLUE}==========================================${NC}"
        echo ""
        echo "Usage: $0 [install|uninstall|test|check|font|help]"
        echo ""
        echo -e "${YELLOW}Commands:${NC}"
        echo "  install   - Install PowerShell profile + modules + Moralerspace font"
        echo "  uninstall - Remove PowerShell profile"
        echo "  test      - Test PowerShell profile syntax"
        echo "  check     - Check PowerShell installation"
        echo "  font      - Install Moralerspace HWJPDOC font only"
        echo "  help      - Show this help message"
        echo ""
        echo -e "${YELLOW}Prerequisites (manual installation):${NC}"
        echo -e "${BLUE}  • Oh My Posh:  winget install JanDeDobbeleer.OhMyPosh${NC}"
        echo ""
        echo -e "${YELLOW}Auto-installed items:${NC}"
        echo "  • Terminal-Icons       - Colorful file/folder icons"
        echo "  • posh-git             - Enhanced Git integration"
        echo "  • Moralerspace HWJPDOC - Japanese programming font"
        echo ""
        echo -e "${YELLOW}Recommended font setting:${NC}"
        echo -e "${BLUE}  'Moralerspace Argon HWJPDOC', 'Consolas', monospace${NC}"
        ;;
    *)
        echo -e "${RED}Unknown option: $1${NC}"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac