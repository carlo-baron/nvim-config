return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "nvim-mini/mini.icons" },
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostic disable: missing-fields

	opts = function()
		local actions = require("fzf-lua").actions
		return {
			files = {
				hidden = true,
				no_ignore = true,
			},
			actions = {
				files = {
					["default"] = actions.file_edit,
				},
			},
		}
	end,
	keys = {
		{
			"<leader>f",
			function()
				require("fzf-lua").files()
			end,
		},
		{
			"<leader>l",
			function()
				require("fzf-lua").live_grep()
			end,
			"norremap",
		},
	},
	---@diagnostic enable: missing-fields
}
