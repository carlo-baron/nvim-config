return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
								workspace = { checkThirdParty = false },
								completion = { callSnippet = "Replace" },
								hint = { enable = true },
							},
						},
					},
					pyright = {},
					vtsls = {
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"typescript.tsx",
						},
						settings = {
							typescript = {
								inlayHints = {
									parameterNames = { enabled = "literals" },
									parameterTypes = { enabled = true },
									variableTypes = { enabled = true },
									propertyDeclarationTypes = { enabled = true },
									functionLikeReturnTypes = { enabled = true },
									enumMemberValues = { enabled = true },
								},
							},
							javascript = {
								inlayHints = {
									parameterNames = { enabled = "literals" },
									parameterTypes = { enabled = true },
									variableTypes = { enabled = true },
									propertyDeclarationTypes = { enabled = true },
									functionLikeReturnTypes = { enabled = true },
									enumMemberValues = { enabled = true },
								},
							},
						},
					},
					omnisharp = {},
					html = {},
					cssls = {},
					clangd = {},
					tailwindcss = {
						filetypes = {
							"html",
							"css",
							"javascriptreact",
							"typescriptreact",
						},
					},
					eslint = {
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
						},
						settings = {
							experimental = { useFlatConfig = false },
							run = "onSave",
						},
					},
				},
			}
		end,
		config = function(_, opts)
			vim.diagnostic.config(opts.diagnostics)
			local server_names = {}
			if opts.servers["*"] then
				vim.lsp.config("*", opts.servers["*"])
			end
			for server, server_opts in pairs(opts.servers) do
				if server ~= "*" then
					vim.lsp.config(server, server_opts)
					table.insert(server_names, server)
				end
			end

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
			vim.keymap.set("n", "<leader>ld", function()
				vim.lsp.enable(server_names, false)
				vim.notify("LSP disabled", vim.log.levels.INFO)
			end, { desc = "Disable configured LSP servers" })

			vim.keymap.set("n", "<leader>lr", function()
				-- Re-enable disabled servers; :lsp restart alone only restarts active clients.
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				vim.lsp.enable(server_names)
				if #clients > 0 then
					vim.cmd("lsp restart")
				end
				vim.notify(#clients > 0 and "LSP restarted" or "LSP enabled", vim.log.levels.INFO)
			end, { desc = "Restart LSP" })

			vim.keymap.set("n", "<leader>lt", function()
				local enabled = false
				for _, server in ipairs(server_names) do
					if vim.lsp.is_enabled(server) then
						enabled = true
						break
					end
				end
				vim.lsp.enable(server_names, not enabled)
				vim.notify("LSP toggled " .. (enabled and "OFF" or "ON"), vim.log.levels.INFO)
			end, { desc = "Toggle configured LSP servers" })

			vim.lsp.enable(server_names)
		end,
	},
}
