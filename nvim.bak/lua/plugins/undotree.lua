return {
  "mbbill/undotree",
  event = "VeryLazy",
  config = function()
    -- Keybinding to toggle Undotree
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

    -- Optional settings
    vim.g.undotree_WindowLayout = 2 -- Sidebar on the right
    vim.g.undotree_ShortIndicators = 1 -- Shorter time indicators
    vim.g.undotree_SetFocusWhenToggle = 1 -- Focus the window when opened
  end,
}