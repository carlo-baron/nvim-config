return {
	"ibhagwan/fzf-lua",
	commit = "d5c12c6",
	lazy = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		files = {
			hidden = true,
			no_ignore = true,
		},
	},
	keys = {
		{
			"<leader>f",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find files",
		},
		{
			"<leader>l",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Live grep",
		},
	},
}
