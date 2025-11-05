# Neovim キーバインドチートシート

このドキュメントでは、LazyVim + カスタム設定のキーバインドを一覧します。

**凡例**
- 🟢 カスタム設定
- 🔵 LazyVimデフォルト
- `<leader>` = `Space`（スペースキー）

---

## 📁 基本操作

### 保存・終了

| キー | 説明 | 種類 |
|------|------|------|
| `<leader>fs` | 💾 ファイル保存 | 🟢 |
| `<leader>qq` | 🚪 すべて終了 | 🔵 |
| `<leader>qd` | 🚪 セッション保存せずに終了 | 🔵 |

### ウィンドウ操作

| キー | 説明 | 種類 |
|------|------|------|
| `<C-h>` | ← 左のウィンドウへ | 🟢 |
| `<C-j>` | ↓ 下のウィンドウへ | 🟢 |
| `<C-k>` | ↑ 上のウィンドウへ | 🟢 |
| `<C-l>` | → 右のウィンドウへ | 🟢 |
| `<C-Up>` | ↑ ウィンドウ高さ増加 | 🟢 |
| `<C-Down>` | ↓ ウィンドウ高さ減少 | 🟢 |
| `<C-Left>` | ← ウィンドウ幅減少 | 🟢 |
| `<C-Right>` | → ウィンドウ幅増加 | 🟢 |

### バッファ操作

| キー | 説明 | 種類 |
|------|------|------|
| `<S-h>` | ← 前のバッファ | 🟢 |
| `<S-l>` | → 次のバッファ | 🟢 |
| `<leader>bd` | 🗑️ バッファ削除 | 🟢 |
| `<leader>bD` | 🗑️ 他のバッファをすべて削除 | 🟢 |
| `<leader>bb` | 📋 バッファ一覧 | 🔵 |
| `<leader>bp` | 📌 バッファをピン留め | 🔵 |

---

## ✏️ 編集操作

### 行移動

| キー | 説明 | 種類 |
|------|------|------|
| `J` (visual) | ↓ 行を下に移動 | 🟢 |
| `K` (visual) | ↑ 行を上に移動 | 🟢 |
| `j` | ↓ 下へ（wrapped対応） | 🟢 |
| `k` | ↑ 上へ（wrapped対応） | 🟢 |

### インデント

| キー | 説明 | 種類 |
|------|------|------|
| `<` (visual) | ← インデント左 | 🟢 |
| `>` (visual) | → インデント右 | 🟢 |

### コピー・ペースト

| キー | 説明 | 種類 |
|------|------|------|
| `p` (visual) | 📋 ペースト（レジスタ保持） | 🟢 |
| `J` (normal) | 🔗 行連結（カーソル位置維持） | 🟢 |

### 検索

| キー | 説明 | 種類 |
|------|------|------|
| `n` | → 次の検索結果（画面中央） | 🟢 |
| `N` | ← 前の検索結果（画面中央） | 🟢 |
| `<Esc>` | 🔍 検索ハイライト解除 | 🟢 |

---

## 🔍 ファイル・検索

### ファイル検索

| キー | 説明 | 種類 |
|------|------|------|
| `<leader>ff` | 🔍 ファイル検索 | 🔵 |
| `<leader>fr` | 🕐 最近開いたファイル | 🔵 |
| `<leader>fg` | 🔎 Grep検索 | 🔵 |
| `<leader>fb` | 📋 バッファ検索 | 🔵 |
| `<leader>fw` | 💬 現在のワードを検索 | 🔵 |

### ファイルエクスプローラー

| キー | 説明 | 種類 |
|------|------|------|
| `<leader>e` | 📁 Explorer（Snacks） | 🟢 |
| `<leader>E` | 📂 Explorer（現在のファイルディレクトリ） | 🟢 |
| `<leader>fe` | 📁 Explorer（ファイル位置） | 🔵 |

---

## 🔀 Git操作

| キー | 説明 | 種類 |
|------|------|------|
| `<leader>gg` | 🔀 LazyGit | 🟢 |
| `<leader>gc` | 📝 コミット | 🔵 |
| `<leader>gs` | 📊 Git Status | 🔵 |
| `<leader>gd` | 📊 Git Diff | 🔵 |
| `<leader>gb` | 📜 Git Blame | 🔵 |
| `<leader>gB` | 🌿 Git Branches | 🔵 |
| `]h` | → 次のHunk | 🔵 |
| `[h` | ← 前のHunk | 🔵 |
| `<leader>ghp` | 👁️ Hunkプレビュー | 🔵 |
| `<leader>ghr` | ↩️ Hunk リセット | 🔵 |
| `<leader>ghs` | ✅ Hunk ステージ | 🔵 |

---

## 💻 コード・LSP

### LSP機能

| キー | 説明 | 種類 |
|------|------|------|
| `gd` | 📍 定義へジャンプ | 🔵 |
| `gr` | 🔍 参照一覧 | 🔵 |
| `gI` | 📍 実装へジャンプ | 🔵 |
| `gy` | 📍 型定義へジャンプ | 🔵 |
| `K` | 📖 Hover情報 | 🔵 |
| `gK` | 📖 Signature Help | 🔵 |
| `<leader>ca` | 💡 Code Action | 🔵 |
| `<leader>cr` | 🔄 Rename | 🔵 |
| `<leader>cf` | ✨ Format | 🔵 |

### 診断

| キー | 説明 | 種類 |
|------|------|------|
| `]d` | → 次のDiagnostic | 🔵 |
| `[d` | ← 前のDiagnostic | 🔵 |
| `]e` | → 次のError | 🔵 |
| `[e` | ← 前のError | 🔵 |
| `]w` | → 次のWarning | 🔵 |
| `[w` | ← 前のWarning | 🔵 |
| `<leader>xx` | 📋 Trouble Toggle | 🔵 |
| `<leader>xX` | 📋 Trouble Workspace | 🔵 |

---

## 💻 ターミナル

| キー | 説明 | 種類 |
|------|------|------|
| `<leader>tt` | 💻 フローティングターミナル | 🟢 |
| `<leader>tT` | 💻 ターミナル（cwd） | 🟢 |
| `<C-/>` | 💻 ターミナルトグル | 🔵 |
| `<Esc><Esc>` (terminal) | ⌨️ Normalモードへ | 🟢 |
| `<C-h/j/k/l>` (terminal) | ⬅️⬇️⬆️➡️ ウィンドウ移動 | 🟢 |

---

## ⚙️ UI・設定

| キー | 説明 | 種類 |
|------|------|------|
| `<leader>L` | 🔌 Lazy（プラグイン管理） | 🟢 |
| `<leader>un` | 🔕 通知をすべて消す | 🟢 |
| `<leader>ul` | 🔢 行番号トグル | 🔵 |
| `<leader>uw` | 📏 Wrap トグル | 🔵 |
| `<leader>us` | 🔤 Spelling トグル | 🔵 |
| `<leader>uc` | 🎨 Colorscheme | 🔵 |

---

## 🎯 便利な操作

### テキストオブジェクト

| キー | 説明 | 種類 |
|------|------|------|
| `viw` | 📝 単語を選択（inner） | Vim標準 |
| `vaw` | 📝 単語を選択（around） | Vim標準 |
| `vi"` | 📝 "内を選択 | Vim標準 |
| `va"` | 📝 "含めて選択 | Vim標準 |
| `vip` | 📝 段落を選択（inner） | Vim標準 |
| `vap` | 📝 段落を選択（around） | Vim標準 |

### コメント

| キー | 説明 | 種類 |
|------|------|------|
| `gcc` | 💬 行コメントトグル | 🔵 |
| `gc` (visual) | 💬 選択範囲コメント | 🔵 |
| `gcO` | 💬 上にコメント追加 | 🔵 |
| `gco` | 💬 下にコメント追加 | 🔵 |

### その他

| キー | 説明 | 種類 |
|------|------|------|
| `<leader>sn` | 🔎 Noice検索 | 🔵 |
| `<leader>L` | 🔌 Lazy（プラグイン管理） | 🔵 |
| `<leader>cm` | 🔧 Mason（LSPインストール） | 🔵 |

---

## 🎓 学習のヒント

### Which-Keyの使い方

1. `<leader>` を押すと、利用可能なキーバインドが表示されます
2. 各グループ（`f`, `g`, `c`など）を押すと、さらに詳細が表示されます
3. 途中で `<Esc>` を押すとキャンセルできます

### よく使うキーバインド（初心者向け）

1. **ファイルを開く**: `<leader>ff` → ファイル名を入力
2. **ファイル保存**: `<leader>fs`
3. **Explorer開く**: `<leader>e`
4. **テキスト検索**: `<leader>fg` → 検索ワードを入力
5. **終了**: `<leader>qq`

### 効率的な編集

1. **行移動**: `V` → `J` or `K` → 行を選択して上下移動
2. **インデント**: `V` → `>` or `<` → インデント調整
3. **コメント**: `gcc` → 行コメントトグル
4. **複数行編集**: `V` → 範囲選択 → `gc` → コメント

---

## ⚠️ checkhealth警告について

`:checkhealth which-key`で表示される「overlapping keymaps」警告について。

### 警告の内容

- `<g>` と `<gc>`, `<gcc>`, `<gd>`, etc. の重複
- `<i>`, `<a>` (visual/operator mode) と text objects の重複
- `<gc>` と `<gcc>`, `<gco>`, `<gcO>` の重複

### これらは問題ではありません

checkhealth自体が明記している通り：

> ✅ OK Most of these checks are for informational purposes only.  
> WARNINGS should be treated as a warning, and don't necessarily indicate a problem with your config.  
> Please |DON'T| report these warnings as an issue.

> ✅ OK Overlapping keymaps are only reported for informational purposes.  
> This doesn't necessarily mean there is a problem with your config.

**これらは正常なVimの動作です：**
- `g` → gotoプレフィックス
- `gc` → commentプレフィックス
- `gcc` → comment line（gcのサブコマンド）
- `i`, `a` → text objectプレフィックス
- `ii`, `ai` → indent text object

### 対策（警告表示を減らす）

`which-key.lua`でpresetsを無効化することで、警告表示を減らせます：

```lua
presets = {
  operators = false,
  motions = false,
  text_objects = false,
  windows = false,
  nav = false,
  z = false,
  g = false,
}
```

**重要**: 警告を完全になくすことは可能ですが、それは実用的なキーバインドを壊すことになります。現在の設定が**ベストバランス**です。

---

## 📚 参考リンク

- [LazyVim公式ドキュメント](https://www.lazyvim.org/)
- [Which-Key使い方](https://github.com/folke/which-key.nvim)
- [Neovim公式チュートリアル](https://neovim.io/doc/user/)

---

## 📝 Neorg

Neorgファイル編集時の専用キーバインドは別ドキュメントを参照してください：

- **[NEORG_KEYBINDS.md](./NEORG_KEYBINDS.md)** - Neorg専用キーバインドチートシート

すべてのNeorgキーバインドは `<LocalLeader>n` プレフィックスに統一されており、他のキーバインドと衝突しません。

---

## 🛠️ カスタマイズ

キーバインドを追加・変更したい場合：

```lua
-- lua/config/keymaps.lua
local map = vim.keymap.set

map("n", "<leader>xx", "<cmd>YourCommand<cr>", { desc = "説明" })
```

Which-Keyグループ名を追加したい場合：

```lua
-- lua/plugins/which-key.lua
spec = {
  { "<leader>x", group = "説明" },
}
```

