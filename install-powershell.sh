#!/bin/bash

# PowerShell Profile installer script for WSL environment
# This script creates symbolic links from the dotfiles directory to Windows PowerShell profile location

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WINDOWS_PROFILE_DIR="/mnt/c/Users/kento/Documents/PowerShell"
WINDOWS_PROFILE_FILE="$WINDOWS_PROFILE_DIR/Microsoft.PowerShell_profile.ps1"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to create Windows directory
create_windows_directory() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        echo -e "${BLUE}Creating Windows directory: $dir${NC}"
        mkdir -p "$dir"
    fi
}

# Function to create Windows symlink to WSL file
create_windows_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"
    
    # Create target directory if it doesn't exist
    create_windows_directory "$(dirname "$target")"
    
    # Convert WSL path to Windows WSL path
    local wsl_source=$(echo "$source" | sed 's|/mnt/c/|C:\\|g' | sed 's|/|\\|g')
    local wsl_source_alt="\\\\wsl.localhost\\Ubuntu$(echo "$source" | sed 's|/home/kento|/home/kento|g' | sed 's|/|\\|g')"
    
    if [ -e "$target" ]; then
        echo -e "${YELLOW}Backing up existing file: $target -> $target.backup${NC}"
        cp "$target" "$target.backup" 2>/dev/null || mv "$target" "$target.backup"
    fi
    
    echo -e "${GREEN}Creating Windows symlink: $name${NC}"
    echo -e "${BLUE}Source (WSL): $source${NC}"
    echo -e "${BLUE}Target (Windows): $target${NC}"
    
    # Use PowerShell to create the symlink from Windows side
    pwsh.exe -Command "
        try {
            if (Test-Path '$target') {
                Remove-Item '$target' -Force
            }
            New-Item -ItemType SymbolicLink -Path '$target' -Target '$wsl_source_alt' -Force
            Write-Host 'Symlink created successfully' -ForegroundColor Green
        } catch {
            Write-Host 'Failed to create symlink:' -ForegroundColor Red
            Write-Host \$_.Exception.Message -ForegroundColor Red
            # Fallback: copy the file instead
            Write-Host 'Falling back to file copy...' -ForegroundColor Yellow
            Copy-Item '$wsl_source_alt' '$target' -Force
        }
    "
}

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