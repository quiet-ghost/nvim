return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For icons in the trouble panel
  },
  event = "LspAttach", -- Load when LSP attaches to a buffer
  opts = {
    position = "bottom", -- Position the panel at the bottom
    height = 10, -- Height of the trouble panel
    icons = true, -- Use devicons for filetypes
    mode = "workspace_diagnostics", -- Default mode (can be changed with keybindings)
    severity = nil, -- Show all severities (error, warning, hint, info)
    fold_open = "v", -- Icon for open folds
    fold_closed = ">", -- Icon for closed folds
    group = true, -- Group diagnostics by file
    padding = true, -- Add padding between trouble panel and editor
    action_keys = { -- Keybindings within the trouble panel
      close = "q", -- Close the panel
      cancel = "<esc>", -- Cancel the preview
      refresh = "r", -- Refresh the list
      jump = { "<cr>", "<tab>" }, -- Jump to the diagnostic
      open_split = { "<c-x>" }, -- Open in horizontal split
      open_vsplit = { "<c-v>" }, -- Open in vertical split
      open_tab = { "<c-t>" }, -- Open in new tab
      jump_close = { "o" }, -- Jump and close the panel
      toggle_mode = "m", -- Toggle between modes (e.g., workspace_diagnostics, document_diagnostics)
      toggle_preview = "P", -- Toggle preview
      hover = "K", -- Show hover information
      preview = "p", -- Preview the location
      close_folds = "zM", -- Close all folds
      open_folds = "zR", -- Open all folds
      toggle_fold = { "zA", "za" }, -- Toggle fold under cursor
    },
    indent_lines = true, -- Add indent guides
    auto_open = false, -- Don’t auto-open on diagnostics
    auto_close = false, -- Don’t auto-close when diagnostics are resolved
    auto_preview = true, -- Auto-preview the location under cursor
    auto_fold = false, -- Don’t auto-fold diagnostics
    use_diagnostic_signs = true, -- Use signs from your LSP config (e.g., ✘, ▲)
  },
}
