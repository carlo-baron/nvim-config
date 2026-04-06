return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },

		opts = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			return {
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
					},
					severity_sort = true,
				},

				servers = {
					["*"] = {
						capabilities = capabilities,
					},

					lua_ls = {
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								completion = {
									callSnippet = "Replace",
								},
								hint = {
									enable = true,
								},
							},
						},
					},
					pyright = {},
					ts_ls = {},
					omnisharp = {},
					html = {},
					css = {},
					clangd = {},
					tailwindcss = {},
					eslint = {},
				},
			}
		end,

		config = function(_, opts)
			vim.diagnostic.config(opts.diagnostics)

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local keymap_opts = { buffer = args.buf }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
					vim.keymap.set("n", "gI", vim.lsp.buf.implementation, keymap_opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)
					vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
				end,
			})

			if opts.servers["*"] then
				vim.lsp.config("*", opts.servers["*"])
			end

			for server, server_opts in pairs(opts.servers) do
				if server ~= "*" then
					vim.lsp.config(server, server_opts)
				end
			end
		end,
	},
}
