return {
  "nvim-lua/plenary.nvim",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<C-f>", "<C-f>zz", { desc = "Page down and center" })
    vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = "Page up and center" })
  end,
}