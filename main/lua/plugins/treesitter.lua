return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"lua", "javascript", "typescript", "tsx",
			"python", "c_sharp", "html", "css",
			"json", "yaml", "markdown", "markdown_inline",
			"bash", "vim", "vimdoc",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua", "javascript", "typescript", "tsx",
				"python", "cs", "html", "css",
				"json", "yaml", "markdown",
				"bash", "vim", "vimdoc",
			},
			callback = function(args)
				local max_filesize = 100 * 1024
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
				if ok and stats and stats.size > max_filesize then
					return
				end
				pcall(vim.treesitter.start)
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua", "javascript", "typescript", "tsx",
				"python", "cs", "html", "css", "json", "yaml",
			},
			callback = function()
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldenable = false
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua", "javascript", "typescript", "tsx",
				"python", "html",
			},
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
