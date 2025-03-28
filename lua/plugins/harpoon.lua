return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy", -- Load after startup
  config = function()
    local harpoon = require("harpoon")

    -- Setup Harpoon
    harpoon:setup()

    -- Keybindings
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu() end, { desc = "Harpoon: Toggle menu" })
    vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to 1" })
    vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to 2" })
    vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to 3" })
    vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to 4" })
  end,
}