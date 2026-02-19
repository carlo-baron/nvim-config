# Neovim Journey
The entire config is inside `init.lua`

I started learning nvim because of [ThePrimeagen](https://www.youtube.com/c/theprimeagen). Seeing him modify his code without touching the mouse is so cool so I then decided that I needed to learn it. Learning it isn't easy, I struggled with basic motions like `hjkl`. But after a week or so it became part of me and from then I tried to improve and tried to learn other tricks. 

I believe everyone who wants to feel cool or just want to have a divorce with their mouse should learn vim motions. You can use my config to get basic LSP and tools to make nvim your main IDE.

---

## Requirements

Make sure the following are installed before using this config:

Core:
- Neovim
- Git
- Node.js
- A C compiler (gcc, clang, or equivalent)
- [vim-plug](https://github.com/junegunn/vim-plug) (neovim)

---

## Installation

1. Install vim-plug (if not already installed).
2. Place this config in:
    <details open>
    <summary>Linux</summary>
    ~/.config/nvim/init.lua
    </details>
    <details open>
    <summary>Windows</summary>
    ~/AppData/Local/nvim/init.lua
    </details>
3. Open Neovim and run:

   :PlugInstall

4. Run:

   :Mason

5. Run:

   :TSUpdate

---

## Features

### LSP Support
- HTML
- CSS
- TypeScript / JavaScript
- PHP (phpactor)
- Python (pyright)
- ESLint
- C# (OmniSharp)
- Emmet
- C/C++ (clangd)

### Autocompletion
- nvim-cmp
- LSP completion
- Buffer completion
- Path completion
- Snippets (LuaSnip + friendly-snippets)

### Syntax & Highlighting
- Treesitter (HTML, CSS, JavaScript, C#, Lua, PHP)
- Indentation support
- True color support

### UI
- tokyonight theme
- lualine statusline
- devicons
- Relative line numbers
- Cursorline highlight

### Navigation & Productivity
- FZF file search (`<Leader>f`)
- Harpoon quick file navigation
- Comment toggling
- vim-surround
- Centered scrolling
- Fast save (`Ctrl+s`)
- `jk` to exit insert mode
- Live Server integration

### Frontend Utilities
- Emmet (HTML/CSS)
- Prettier formatting (`<Leader>p`)
- 2-space indentation automatically for JS/TS/React

---

## Keymaps

Leader key: Space

File Navigation:
- `<Leader>f` → FZF file search
- `<Leader>e` → File explorer
- `<Leader>a` → Add file to Harpoon
- `<Leader>h` → Toggle Harpoon menu
- `<Leader>1-4` → Jump to Harpoon file

LSP:
- `gd` → Go to definition
- `K` → Hover documentation
- `<Leader>rn` → Rename symbol

Editing:
- `jk` → Exit insert mode
- `Ctrl+s` → Save file
- `<Leader>p` → Run Prettier on current file

Scrolling:
- `Ctrl+d` / `Ctrl+u` → Centered scrolling
- `n` / `N` → Centered search results
