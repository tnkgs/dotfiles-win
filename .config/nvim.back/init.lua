-- lazy.nvim の読み込み
require 'config.lazy'

-- オプション設定 (vim.opt)
local opt = vim.opt

-- リーダーキーの設定 (Spaceキーをリーダーキーにする)
-- (例: <Space>f など、独自のショートカットキーの起点となるキー)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 1. 基本的なエディタ設定
opt.encoding = 'utf-8'          -- エンコーディングをUTF-8に
opt.number = true               -- 行番号を表示
opt.relativenumber = true       -- 相対行番号も表示 (カーソル行からの行数がわかる)
opt.mouse = 'a'                 -- マウス操作を有効にする (すべてのモードで)
opt.wrap = false                -- 長い行を折り返さない
opt.title = true                -- ウィンドウのタイトルにファイル名を表示

-- 2. タブとインデント設定
opt.tabstop = 4                 -- タブの幅 (4スペース分)
opt.shiftwidth = 4              -- 自動インデントの幅 (4スペース分)
opt.expandtab = true            -- タブキーを押したときにスペースを挿入する
opt.autoindent = true           -- 改行時に自動でインデントする

-- 3. 検索設定
opt.hlsearch = true             -- 検索結果をハイライト表示
opt.incsearch = true            -- インクリメンタルサーチ (入力中に検索結果をプレビュー)
opt.ignorecase = true           -- 検索時に大文字/小文字を区別しない
opt.smartcase = true            -- 検索文字列に大文字が含まれている場合は、大文字/小文字を区別する

-- 4. クリップボード設定 (前回の会話より)
-- OSのクリップボードと連携する (yでヤンクした内容をOSのクリップボードに入れる)
-- 前提: wsl-clipboard または xclip が正しく動作している必要があります
opt.clipboard = 'unnamedplus'

-- 5. ユーザーインターフェース設定
opt.termguicolors = true        -- ターミナルのTrue Colorを有効にする (カラースキームに必要)
opt.signcolumn = 'yes'          -- 常に符号列 (Gitの差分やLSPの警告) を表示するスペースを確保

-- 6. その他
opt.backspace = 'indent,eol,start' -- バックスペースの動作を直感的にする
opt.swapfile = false            -- スワップファイルを作成しない
opt.backup = false              -- バックアップファイルを作成しない
opt.undofile = true             -- アンドゥ履歴をファイルに保存する (vimを閉じてもアンドゥが効く)
