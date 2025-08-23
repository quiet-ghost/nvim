return {
  "luckasRanarison/nvim-devdocs",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    wrap = true, -- Enable text wrapping for better readability
    telescope = {
      -- Telescope-specific configuration
      layout_strategy = "vertical", -- Vertical layout for better markdown readability
      layout_config = {
        vertical = {
          preview_height = 0.8, -- Maximum preview area
          preview_cutoff = 0,
          mirror = false,
        },
        width = 0.95, -- Nearly full screen width
        height = 0.95, -- Nearly full screen height
      },
    },
    picker_cmd = false, -- Use native rendering for syntax highlighting
    picker_cmd_args = {}, -- No args needed for native rendering
    previewer_cmd = "glow", -- Use glow for floating window preview
    cmd_args = { "-s", "dark", "-w", "100" }, -- Glow arguments for floating window
    float_win = { -- Improve floating window
      relative = "editor",
      height = 35,
      width = 130,
      border = "rounded",
    },
  },
}
