#!/bin/bash

# PowerShell Profile installer script for WSL environment
# This script creates symbolic links from the dotfiles directory to Windows PowerShell profile location

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to install PowerShell profile
install_powershell_profile() {
    echo -e "${GREEN}Installing PowerShell profile...${NC}"
    
    local windows_dotfiles="/mnt/c/Users/kento/dotfiles"
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
    
    local windows_dotfiles="/mnt/c/Users/kento/dotfiles"
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
    
    local windows_dotfiles="/mnt/c/Users/kento/dotfiles"
    local ps_script="$windows_dotfiles/install-powershell.ps1"
    
    if [ -f "$ps_script" ]; then
        echo -e "${BLUE}Running PowerShell test script from Windows directory...${NC}"
        cd "$windows_dotfiles" && pwsh.exe -File "install-powershell.ps1" -Action test
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
    "help"|"-h"|"--help")
        echo "Usage: $0 [install|uninstall|test|check|help]"
        echo "  install   - Install PowerShell profile (default)"
        echo "  uninstall - Remove PowerShell profile symlink"
        echo "  test      - Test PowerShell profile syntax"
        echo "  check     - Check PowerShell installation"
        echo "  help      - Show this help message"
        ;;
    *)
        echo -e "${RED}Unknown option: $1${NC}"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac