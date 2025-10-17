# PowerShell Profile Configuration
# This file is managed by dotfiles repository

# Set execution policy for current user (if needed)
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Import modules
Import-Module PSReadLine -ErrorAction SilentlyContinue

# PSReadLine configuration
if (Get-Module -ListAvailable -Name PSReadLine) {
    # Enable prediction
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    
    # Enable syntax highlighting
    Set-PSReadLineOption -Colors @{
        Command = 'Cyan'
        Parameter = 'Gray'
        Operator = 'Magenta'
        Variable = 'Green'
        String = 'Yellow'
        Number = 'Red'
        Type = 'Blue'
        Comment = 'DarkGreen'
    }
    
    # Key bindings
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteChar
    Set-PSReadLineKeyHandler -Key Ctrl+z -Function Undo
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# Aliases
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name la -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String
Set-Alias -Name which -Value Get-Command

# Functions
function Get-ChildItemColor {
    Get-ChildItem | ForEach-Object {
        if ($_.PSIsContainer) {
            Write-Host $_.Name -ForegroundColor Blue
        } else {
            Write-Host $_.Name -ForegroundColor White
        }
    }
}
Set-Alias -Name ls -Value Get-ChildItemColor

# WSL integration
function wsl {
    param([string]$Command = "")
    if ($Command) {
        wsl.exe $Command
    } else {
        wsl.exe
    }
}

# Git integration
function Get-GitStatus { git status }
function Get-GitLog { git log --oneline --graph --decorate }
function Get-GitBranch { git branch -a }
Set-Alias -Name gs -Value Get-GitStatus
Set-Alias -Name gl -Value Get-GitLog
Set-Alias -Name gb -Value Get-GitBranch

# Navigation helpers
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }

# Quick edit functions
function Edit-Profile { 
    code $PROFILE 
}

function Import-Profile {
    . $PROFILE
}
Set-Alias -Name reload -Value Import-Profile

# Environment variables
$env:EDITOR = "code"

# Prompt customization
function prompt {
    $currentPath = (Get-Location).Path
    $gitBranch = ""
    
    # Check if we're in a git repository
    if (Test-Path .git) {
        $gitBranch = " ($(git branch --show-current 2>$null))"
    }
    
    # Set prompt with colors
    Write-Host "PS " -NoNewline -ForegroundColor Green
    Write-Host "$currentPath" -NoNewline -ForegroundColor Cyan
    Write-Host "$gitBranch" -NoNewline -ForegroundColor Yellow
    Write-Host "> " -NoNewline -ForegroundColor Green
    
    return " "
}

# Welcome message
Write-Host "PowerShell Profile Loaded Successfully!" -ForegroundColor Green
Write-Host "Type 'Get-Help' for help or 'Edit-Profile' to edit this profile" -ForegroundColor Gray