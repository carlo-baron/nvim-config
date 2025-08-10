vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'morhetz/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/tokyonight.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'barrett-ruth/live-server.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'ThePrimeagen/harpoon'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
call plug#end()
]]

-- Plugin-specific setups
require("live-server").setup()
require('lualine').setup({
    options = { theme = 'tokyonight' }
})
require('Comment').setup()

-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd.colorscheme('tokyonight-night')

vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.guicursor = ''
vim.opt.mouse = ''
vim.opt.scrolloff = 5
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.g.mapleader = ' '
vim.g.user_emmet_leader_key = '<C-Z>'

vim.cmd([[
  syntax enable
  syntax on
  filetype plugin indent on
  autocmd FileType html,css EmmetInstall
]])

-- Escape key remap
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })

-- FZF Mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<Leader>f', ':Files<CR>', opts)
map('n', '<Leader>e', ':Ex<CR>', opts)

-- harpoon stuff
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<Leader>a', mark.add_file, opts)
map('n', '<Leader>h', ui.toggle_quick_menu, opts)
map('n', '<Leader>r', mark.rm_file, opts)
map('n', '<Leader>c', mark.clear_all, opts)

map('n', '<Leader>1', function() ui.nav_file(1) end, opts)
map('n', '<Leader>2', function() ui.nav_file(2) end, opts)
map('n', '<Leader>3', function() ui.nav_file(3) end, opts)
map('n', '<Leader>4', function() ui.nav_file(4) end, opts)

vim.g.fzf_preview_window = { 'right:50%', 'ctrl-/' }

-- Better scrolling
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)

-- LSP Keymaps
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

-- Prettier run
--map('n', '<Leader>p', ':!prettier --write %<CR>', opts)
map('n', '<Leader>p', ':!npx prettier --plugin=@prettier/plugin-php --write %<CR>', opts)

-- Other Settings
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Save with Ctrl+S
map('n', '<C-s>', ':w<CR>', opts)
map('i', '<C-s>', '<Esc>:w<CR>i', opts)

-- LSP Setup (Mason + LSPConfig)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "html",
        "cssls",
        "ts_ls",
        "phpactor",
        "pyright",
        "eslint",
        "omnisharp",
        "emmet_ls"
    },
})
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "html", "css", "javascript", "c_sharp", "lua", "php" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

-- snippets
local cmp = require'cmp'
local luasnip = require'luasnip'

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

lspconfig.html.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.ts_ls.setup({ capabilities = capabilities })
lspconfig.phpactor.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.eslint.setup({ capabilities = capabilities })
lspconfig.emmet_ls.setup({ capabilities = capabilities })
