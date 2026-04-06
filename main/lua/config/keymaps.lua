vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { silent = true })
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<CR>")
vim.keymap.set("i", "jk", "<Esc>", { silent = true })
