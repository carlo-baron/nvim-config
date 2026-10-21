vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.wo.number = true
		vim.wo.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescriptreact", "javascriptreact", "html" },
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
