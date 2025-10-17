# Dotfiles

WSL/Windows統合dotfiles管理。

## 構成

```
├── .zshrc, .bashrc, .gitconfig, .vimrc, .tmux.conf
├── .p10k.zsh                        # Powerlevel10k (awesome-fontconfig)
├── Microsoft.PowerShell_profile.ps1 # PSReadLine + Terminal-Icons + posh-git
├── ohmyposh-theme.omp.json          # Oh My Posh custom theme
├── install.sh / install-powershell.ps1
└── Moralerspace HWJPDOC (auto-install)
```

## クイックスタート

**注意：** このリポジトリはWindows側（`C:\Users\kento\dotfiles\`）に配置されており、WSL環境からはシンボリックリンク（`~/dotfiles`）でアクセスします。

### WSL (Zsh + Powerlevel10k)
```bash
./install.sh install
source ~/.zshrc
```

### PowerShell (Oh My Posh + custom theme)
```powershell
winget install JanDeDobbeleer.OhMyPosh
.\install-powershell.ps1 install  # Modules + Moralerspace font
```

**Font:** Windows Terminal → `Moralerspace Neon HWJPDOC`

## 管理

```bash
# Sync
git pull && ./install.sh install

# Update modules
./install-powershell.ps1 install  # PowerShell
./install.sh install              # Zsh

# Font reinstall
./install-powershell.ps1 font
```

## カスタマイズ

### Zsh (Powerlevel10k)
```bash
p10k configure  # Wizard
# or edit .p10k.zsh directly
```

### PowerShell (Oh My Posh)
```powershell
code $PROFILE  # Microsoft.PowerShell_profile.ps1
code C:\Users\kento\dotfiles\ohmyposh-theme.omp.json
reload
```

## 設定詳細

**Zsh**: Oh My Zsh + Powerlevel10k (awesome-fontconfig mode)  
**PowerShell**: Oh My Posh (custom theme) + Terminal-Icons + posh-git  
**Font**: Moralerspace HWJPDOC Nerd Font (auto-installed)

詳細: `POWERSHELL_SETUP.md`, `FONT_INSTALLATION_GUIDE.md`