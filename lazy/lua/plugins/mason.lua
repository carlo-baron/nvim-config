return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "html",
        "cssls",
        "typescript_language_server",
        "phpactor",
        "pyright",
        "eslint",
        "omnisharp",
        "emmet_language_server",
        "clangd",
      },
    },
  },
}
