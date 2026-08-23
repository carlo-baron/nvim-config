return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	lazy = false,
	opts = {
		enable_autocmd = false,
	},
	config = function(_, opts)
		require("ts_context_commentstring").setup(opts)

		-- Neovim's built-in comment (gc/gcc) asks vim.filetype.get_option for the
		-- commentstring of the tree-sitter language under the cursor, so override
		-- it to answer context-aware (e.g. {/* */} in JSX, // in plain TS).
		local get_option = vim.filetype.get_option
		vim.filetype.get_option = function(filetype, option)
			return option == "commentstring"
					and require("ts_context_commentstring.internal").calculate_commentstring()
				or get_option(filetype, option)
		end
	end,
}
