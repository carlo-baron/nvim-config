return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- ADD FILE
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon add file" })

    -- REMOVE CURRENT FILE
    vim.keymap.set("n", "<leader>r", function()
      harpoon:list():remove()
    end, { desc = "Harpoon remove file" })

    -- CLEAR ALL FILES
    vim.keymap.set("n", "<leader>c", function()
      harpoon:list():clear()
    end, { desc = "Harpoon clear all files" })

    -- HARPOON QUICK MENU
    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon quick menu" })

    -- SELECT FILES
    for i = 1, 4 do
      vim.keymap.set("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end, { desc = "Harpoon select file " .. i })
    end
  end,
}
