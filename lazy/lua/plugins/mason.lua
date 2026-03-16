return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "html",
        "cssls",
        "phpactor",
        "pyright",
        "eslint",
        "emmet_language_server",
        "clangd",
        "ts_ls",
        "omnisharp",
      },
    },
  },
}
