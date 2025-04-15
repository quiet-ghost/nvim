return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_verbose = 1  -- Enable verbose output for debugging
    vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Go to the left pane", silent = true })
    vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Go to the down pane", silent = true })
    vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Go to the up pane", silent = true })
    vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Go to the right pane", silent = true })
    vim.keymap.set("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", { desc = "Go to the previous pane", silent = true })
    vim.keymap.set("t", "<C-h>", "<C-\\><C-n>:TmuxNavigateLeft<CR>", { desc = "Go to the left pane", silent = true })
    vim.keymap.set("t", "<C-j>", "<C-\\><C-n>:TmuxNavigateDown<CR>", { desc = "Go to the down pane", silent = true })
    vim.keymap.set("t", "<C-k>", "<C-\\><C-n>:TmuxNavigateUp<CR>", { desc = "Go to the up pane", silent = true })
    vim.keymap.set("t", "<C-l>", "<C-\\><C-n>:TmuxNavigateRight<CR>", { desc = "Go to the right pane", silent = true })
    vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>:TmuxNavigatePrevious<CR>", { desc = "Go to the previous pane", silent = true })
  end,
}
