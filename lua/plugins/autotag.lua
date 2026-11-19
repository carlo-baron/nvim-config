return {
	"windwp/nvim-ts-autotag",
	event = "BufReadPost",
	opts = {
		filetypes = {
			"html", "xml",
			"javascript", "javascriptreact",
			"typescript", "typescriptreact",
			"vue", "svelte",
		},
	},
}
