return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			-- lspconfig.lua enables our chosen servers. Auto-enabling every installed
			-- server also starts ts_ls alongside vtsls, duplicating definition results.
			automatic_enable = false,
			ensure_installed = {
				"lua_ls",
				"pyright",
				"vtsls",
				"omnisharp",
				"html",
				"cssls",
				"clangd",
				"tailwindcss",
				"eslint",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
