# Dotfiles

WSL Ubuntu環境でのdotfiles管理リポジトリです。Homesickのような機能を提供します。

## 概要

このリポジトリは、コンソール設定ファイル（.zshrc、.bashrc、.gitconfigなど）をGitで管理し、複数の環境で簡単に同期できるようにします。

## ファイル構成

```
dotfiles/
├── .zshrc                          # Zsh設定ファイル
├── .bashrc                         # Bash設定ファイル
├── .gitconfig                      # Git設定ファイル（オプション）
├── .vimrc                          # Vim設定ファイル（オプション）
├── .tmux.conf                      # Tmux設定ファイル（オプション）
├── .gitignore_global               # グローバルGitignore（オプション）
├── Microsoft.PowerShell_profile.ps1 # PowerShell設定ファイル（Windows）
├── .config/                        # 設定ディレクトリ
├── install.sh                      # メインインストールスクリプト
├── install-powershell.sh           # PowerShell専用インストールスクリプト
├── .gitignore                      # Gitignore設定
└── README.md                       # このファイル
```

## 使用方法

### WSL環境でのPowerShell設定

このdotfilesリポジトリはWSL環境とWindows側のPowerShell設定を統合管理できます。

**PowerShell設定の特徴：**
- PSReadLineによる高度なコマンドライン編集
- シンタックスハイライト
- 予測入力機能
- WSL統合コマンド
- Git統合エイリアス
- カスタムプロンプト

**注意：** このリポジトリはWindows側（`C:\Users\kento\dotfiles\`）に配置されており、WSL環境からはシンボリックリンクでアクセスします。

### 初回セットアップ

1. リポジトリをクローンまたはダウンロード
2. インストールスクリプトを実行

**WSL環境から：**
```bash
cd ~/dotfiles
./install.sh install

# PowerShell設定もインストール
./install-powershell.sh install
```

**Windows環境から：**
```powershell
cd C:\Users\kento\dotfiles
.\install-powershell.ps1 -Action install
```

### 新しい設定ファイルの追加

1. dotfilesディレクトリに設定ファイルを追加
2. 必要に応じてinstall.shスクリプトを更新
3. Gitでコミット

```bash
# 例：.vimrcを追加
cp ~/.vimrc ~/dotfiles/
git add .vimrc
git commit -m "Add vim configuration"
```

### 設定の同期

他の環境で設定を同期する場合：

**WSL環境から：**
```bash
cd ~/dotfiles
git pull origin main
./install.sh install
./install-powershell.sh install
```

**Windows環境から：**
```powershell
cd C:\Users\kento\dotfiles
git pull origin main
.\install-powershell.ps1 -Action install
```

### アンインストール

シンボリックリンクを削除して元の設定に戻す：

**WSL環境から：**
```bash
./install.sh uninstall
./install-powershell.sh uninstall
```

**Windows環境から：**
```powershell
.\install-powershell.ps1 -Action uninstall
```

## インストールスクリプトの機能

### メインスクリプト (`install.sh`)
- **自動バックアップ**: 既存の設定ファイルは`.backup`拡張子でバックアップされます
- **シンボリックリンク作成**: 設定ファイルへのシンボリックリンクを自動作成
- **安全な上書き**: 既存のシンボリックリンクは安全に置き換えられます
- **エラーハンドリング**: 存在しないファイルはスキップされます

### PowerShellスクリプト (`install-powershell.sh`)
- **Windows統合**: WSL環境からWindows側のPowerShell設定を管理
- **PowerShell検証**: PowerShell Coreのインストール状況を確認
- **構文チェック**: PowerShellプロファイルの構文を検証
- **自動ディレクトリ作成**: Windows側の必要なディレクトリを自動作成

## カスタマイズ

### 新しい設定ファイルを追加する場合

1. `install.sh`の`files`配列にファイル名を追加
2. ファイルをdotfilesディレクトリに配置
3. インストールスクリプトを実行

### .configディレクトリの管理

`.config`ディレクトリ内の設定ファイルも自動的に管理されます。例：

```bash
mkdir -p ~/dotfiles/.config/nvim
cp -r ~/.config/nvim/* ~/dotfiles/.config/nvim/
```

## 注意事項

- このスクリプトは既存の設定ファイルをバックアップしますが、重要な設定は事前にバックアップを取ることを推奨します
- WSL環境で動作することを前提としています
- シンボリックリンクを使用するため、Windows側からもアクセス可能です

## トラブルシューティング

### シンボリックリンクが作成されない場合

```bash
# 権限を確認
ls -la ~/dotfiles/install.sh

# 実行権限を付与
chmod +x ~/dotfiles/install.sh
```

### 設定が反映されない場合

```bash
# シェルを再起動
exec zsh

# または設定を再読み込み
source ~/.zshrc
```

## ライセンス

このプロジェクトは個人使用を目的としています。