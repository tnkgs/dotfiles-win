# archlinuxの操作メモ

## weztermの導入

```powershell
winget install wez.wezterm
```
[WezTerm セットアップガイド](WEZTERM_SETUP.md)

## archlinuxの初期化

```sh
pacman-key --init
pacman-key --populate
pacman -Syu
pacman -S base-devel git openssh vim wget curl sudo
useradd -m -G wheel -s /bin/bash kento
passwd kento
passwd
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
```
default userを設定
```sh
sudo vim /etc/wsl.conf
```
以下を追加
```toml
[user]
default = kento
```

system-loginの設定
```sh
sudo vim /etc/pam.d/system-login
```
以下を編集
```text
# - session optional pam_systemd.so から以下に変更
session optional pam_systemd.so
```

waylandのruntime-dirを設定
```sh
ln -sf /mnt/wslg/runtime-dir/wayland-0* /run/user/${USER_ID}/
```

## 言語環境の設定

```sh
sudo vim /etc/locale.gen
```

以下、コメントアウトを解除
```text
ja_JP.UTF-8 UTF-8
en_US.UTF-8 UTF-8
```
ロケールを生成
```sh
locale-gen
```
ロケールを設定
```sh
sudo vim /etc/locale.conf
```
以下を設定
```text
LANG=en_US.UTF-8
```

## zshの導入

```sh
sudo pacman -S zsh
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 以下はinstall.shで対応済みなので不要
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

## pacmanで導入したパッケージ

```sh
# ターミナルマルチプレクサ
sudo pacman -S tmux
# システム情報表示
sudo pacman -S screeenfetch
# グラフィックスドライバ
sudo pacman -S mesa 
# Vulkan対応
sudo pacman -S vulkan-dzn
# Vulkan対応
sudo pacman -S vulkan-icd-loader
# Vulkan対応
sudo pacman -S lib32-vulkan-icd-loader
# クリップボード
sudo pacman -S wl-clipboard
# 時計
sudo pacman -S peaclock
# テキストエディタ
sudo pacman -S neovim
# カレンダー
sudo pacman -S khal
```

## paruの導入

```sh
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```
※ `install.sh` で対応済みなので不要

yayのAliasを設定 `~/.zshrc` に追加
```sh
alias yay='paru'
```

## paruで導入したパッケージ

```sh
yay -S vdirsyncer
# vdirsyncerでgoogle calendarを使うために必要
yay -S python-aiohttp-oauthlib
# WSLg動作確認用
yay -S xorg-xeyes
```

## wsl2-ssh-agentの導入

```sh
curl -L -O https://github.com/mame/wsl2-ssh-agent/releases/latest/download/wsl2-ssh-agent
chmod 755 wsl2-ssh-agent
mkdir -p ~/.local/bin
mv wsl2-ssh-agent ~/.local/bin
```

※ `install.sh` で対応済みなので不要

## vdirsyncerの設定

```sh
yay -S vdirsyncer
mkdir -p ~/.config/vdirsyncer
mkdir -p ~/.vdirsyncer/status
mkdir -p ~/.local/state/vdirsyncer
mkdir -p ~/.calendars/gcal/
touch ~/.config/vdirsyncer/config
```
以下のように設定ファイルを作成
```toml
[general]
status_path = "~/.vdirsyncer/status/"

[pair gcal]
a = "gcal_local"
b = "gcal_remote"
collections = ["from a", "from b"]
metadata = ["displayname"]

[storage gcal_local]
type = "filesystem"
path = "~/.calendars/gcal/"
fileext = ".ics"

[storage gcal_remote]
type = "google_calendar"
token_file = "~/.local/state/vdirsyncer/gcal_remote_token"
client_id = "GOOGLE_CLIENT_ID"
client_secret = "GOOGLE_CLIENT_SECRET"
```

設定の反映と同期
```sh
vdirsyncer discover
vdirsyncer sync
# vdirsyncerの定期実行を有効にする
systemctl --user enable vdirsyncer.timer
```

## khalの設定

```sh
mkdir -p ~/.config/khal
vim ~/.config/khal/config
```
以下のように設定ファイルを作成
```toml
[calendars]
[[gcal-cal]]
path = ~/.calendars/gcal/example@example.com

[[gcal-todo]]
path = ~/.calendars/gcal/xxxxxx@virtual

[locale]
local_timezone= Asia/Tokyo
default_timezone= Asia/Tokyo
timeformat= %H:%M
dateformat= %m-%d
longdateformat= %Y-%m-%d
datetimeformat= %m-%d %H:%M
longdatetimeformat= %Y-%m-%d %H:%M
```
