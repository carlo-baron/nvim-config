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

			local lsp_enabled = true

			vim.keymap.set("n", "<leader>ld", function()
				vim.cmd("lsp disable")
				lsp_enabled = false
				vim.notify("LSP disabled", vim.log.levels.INFO)
			end, { desc = "Disable LSP (buffer)" })

			vim.keymap.set("n", "<leader>lr", function()
				vim.cmd("lsp restart")
				lsp_enabled = true
				vim.notify("LSP restarted", vim.log.levels.INFO)
			end, { desc = "Restart LSP" })

			vim.keymap.set("n", "<leader>lt", function()
				if lsp_enabled then
					vim.cmd("lsp disable")
					lsp_enabled = false
					vim.notify("LSP toggled OFF", vim.log.levels.INFO)
				else
					vim.cmd("lsp enable")
					lsp_enabled = true
					vim.notify("LSP toggled ON", vim.log.levels.INFO)
				end
			end, { desc = "Toggle LSP" })

			if opts.servers["*"] then
				vim.lsp.config("*", opts.servers["*"])
			end

			for server, server_opts in pairs(opts.servers) do
				if server ~= "*" then
					vim.lsp.config(server, server_opts)
					vim.lsp.enable(server)
				end
			end
		end,
	},
}
