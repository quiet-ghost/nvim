return {
  "marko-cerovac/material.nvim",
  lazy = false, -- Load immediately
  priority = 1000, -- Ensure it applies early
  config = function()
    -- Configure Material with optional settings
    require("material").setup({
      contrast = {
        terminal = true,
        sidebars = true,
      },
      plugins = {
        "dap",
        "nvim-cmp",
      },
      disable = {
        colored_cursor = false,
        borders = false,
      },
      high_visibility = {
        darker = true,
      },
    })

    -- Set the Deep Ocean style
    vim.g.material_style = "deep ocean"

    -- Apply the colorscheme
    vim.cmd("colorscheme material")
  end,
}