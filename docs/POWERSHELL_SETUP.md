# PowerShell Setup

## インストール

```powershell
winget install JanDeDobbeleer.OhMyPosh
.\install-powershell.ps1 install
```

自動インストール：Terminal-Icons, posh-git, Moralerspace HWJPDOC

## 設定

**Theme:** `ohmyposh-theme.omp.json` (custom powerline)  
**Font:** `Moralerspace Neon HWJPDOC`

Windows Terminal: `Ctrl+,` → Font face → `Moralerspace Neon HWJPDOC`

## カスタマイズ

```powershell
code $PROFILE                                          # Profile
code C:\Users\kento\dotfiles\ohmyposh-theme.omp.json  # Theme
reload                                                 # Apply
```

## コマンド

```powershell
# Profile
reload          # Reload profile
Edit-Profile    # Edit profile

# Git
gst             # git status

# Navigation
..              # cd ..
...             # cd ../..

# Aliases
ll              # Get-ChildItem
grep            # Select-String
which           # Get-Command
```

## モジュール

- **PSReadLine**: 予測入力、構文ハイライト、履歴検索
- **Terminal-Icons**: ファイル/フォルダアイコン
- **posh-git**: Git情報表示

## フォント再インストール

```powershell
.\install-powershell.ps1 font
```

インストール先: `%LocalAppData%\Microsoft\Windows\Fonts` (管理者権限不要)

## リンク

- [Oh My Posh](https://ohmyposh.dev/)
- [Moralerspace](https://github.com/yuru7/moralerspace)
- [Terminal-Icons](https://github.com/devblackops/Terminal-Icons)
- [posh-git](https://github.com/dahlbyk/posh-git)
