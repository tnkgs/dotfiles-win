# PowerShell Profile Installer Script
# This script manages PowerShell profile installation from WSL environment

param(
    [string]$Action = "install"
)

# Colors for output
$ErrorActionPreference = "Continue"

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Test-PowerShellInstallation {
    Write-ColorOutput "Checking PowerShell installation..." "Blue"
    
    try {
        $version = $PSVersionTable.PSVersion
        Write-ColorOutput "PowerShell found: $version" "Green"
        return $true
    } catch {
        Write-ColorOutput "PowerShell not found. Please install PowerShell Core." "Red"
        Write-ColorOutput "Download from: https://github.com/PowerShell/PowerShell/releases" "Yellow"
        return $false
    }
}

function Install-PowerShellProfile {
    Write-ColorOutput "Installing PowerShell profile..." "Green"
    
    $profilePath = $PROFILE
    $wslSourcePath = "C:\Users\kento\dotfiles\Microsoft.PowerShell_profile.ps1"
    
    # Create profile directory if it doesn't exist
    $profileDir = Split-Path $profilePath -Parent
    if (!(Test-Path $profileDir)) {
        Write-ColorOutput "Creating profile directory: $profileDir" "Blue"
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    
    # Backup existing profile
    if (Test-Path $profilePath) {
        Write-ColorOutput "Backing up existing profile: $profilePath -> $profilePath.backup" "Yellow"
        Copy-Item $profilePath "$profilePath.backup" -Force
    }
    
    # Copy profile from WSL
    try {
        Write-ColorOutput "Copying profile from WSL..." "Blue"
        Copy-Item $wslSourcePath $profilePath -Force
        Write-ColorOutput "PowerShell profile installed successfully!" "Green"
        Write-ColorOutput "Profile location: $profilePath" "Blue"
        Write-ColorOutput "To reload the profile, run: Reload-Profile" "Yellow"
        return $true
    } catch {
        Write-ColorOutput "Failed to copy profile: $($_.Exception.Message)" "Red"
        return $false
    }
}

function Uninstall-PowerShellProfile {
    Write-ColorOutput "Uninstalling PowerShell profile..." "Yellow"
    
    $profilePath = $PROFILE
    
    if (Test-Path $profilePath) {
        Write-ColorOutput "Removing profile: $profilePath" "Green"
        Remove-Item $profilePath -Force
        Write-ColorOutput "PowerShell profile uninstalled successfully!" "Green"
    } else {
        Write-ColorOutput "No PowerShell profile found" "Yellow"
    }
}

function Test-PowerShellProfile {
    Write-ColorOutput "Testing PowerShell profile..." "Blue"
    
    $profilePath = $PROFILE
    
    if (Test-Path $profilePath) {
        Write-ColorOutput "Profile file exists: $profilePath" "Green"
        
        # Test syntax
        try {
            $null = [System.Management.Automation.PSParser]::Tokenize((Get-Content $profilePath -Raw), [ref]$null)
            Write-ColorOutput "Profile syntax is valid" "Green"
        } catch {
            Write-ColorOutput "Profile syntax error: $($_.Exception.Message)" "Red"
        }
    } else {
        Write-ColorOutput "Profile file not found: $profilePath" "Red"
    }
}

function Show-Help {
    Write-ColorOutput "Usage: .\install-powershell.ps1 [install|uninstall|test|check|help]" "White"
    Write-ColorOutput "  install   - Install PowerShell profile (default)" "White"
    Write-ColorOutput "  uninstall - Remove PowerShell profile" "White"
    Write-ColorOutput "  test      - Test PowerShell profile syntax" "White"
    Write-ColorOutput "  check     - Check PowerShell installation" "White"
    Write-ColorOutput "  help      - Show this help message" "White"
}

# Main script logic
switch ($Action.ToLower()) {
    "install" {
        if (Test-PowerShellInstallation) {
            Install-PowerShellProfile
        }
    }
    "uninstall" {
        Uninstall-PowerShellProfile
    }
    "test" {
        Test-PowerShellProfile
    }
    "check" {
        Test-PowerShellInstallation
    }
    "help" {
        Show-Help
    }
    default {
        Write-ColorOutput "Unknown option: $Action" "Red"
        Show-Help
        exit 1
    }
}