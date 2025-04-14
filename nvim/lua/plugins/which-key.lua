return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",-- Use modern preset for a clean, LazyVim-like look
    triggers = { "<leader>" }, -- Trigger keys
    plugins = {
      marks = true, -- Show marks
      registers = true, -- Show registers
      spelling = { enabled = true, suggestions = 20 }, -- Spell suggestions
    },
    win = {
      border = "rounded", -- Rounded borders for the floating window
      padding = { 1, 2 }, -- Padding: { top/bottom, left/right }
      wo = {
        winblend = 10, -- Slight transparency (0 = opaque, 100 = fully transparent)
      },
    },
    layout = {
      align = "right", -- Center the floating window
      spacing = 4, -- Space between columns
      height = { min = 4, max = 25 }, -- Constrain window height
      width = { min = 20, max = 50 }, -- Constrain window width
    },
    icons = {
      breadcrumb = "»", -- Separator for keymap paths
      separator = "➜", -- Arrow between keys and descriptions
      group = "+", -- Icon for keymap groups
    },
    show_help = true, -- Show help message in the popup
    show_keys = true, -- Show the keybinding in the popup
    delay = 200, -- Time (ms) before showing the popup (adjust for responsiveness)
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register keybindings with groups
    wk.add({
      { "<leader>?", function() wk.show({ global = false }) end, desc = "Buffer Local Keymaps" },
      { "<leader>f", group = "find" }, -- Group for find-related keymaps
      { "<leader>b", group = "buffer" }, -- Group for buffer keymaps
      { "<leader>g", group = "git" }, -- Group for git keymaps
      { "<leader>l", group = "lsp" }, -- Group for LSP keymaps
    })
  end,
}