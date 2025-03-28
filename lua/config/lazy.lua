local lazy = require("lazy")

lazy.setup({
  spec = {
    -- LazyVim standard plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Kickstart-inspired extras (optional LSP, formatting, etc.)
    { import = "lazyvim.plugins.extras.lang.typescript" }, -- Example, adjust as needed
    -- Custom plugins
    { import = "plugins" },
  },
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "tarPlugin", "netrwPlugin" },
    },
  },
  -- Set Material colorscheme
  colorscheme = function()
    require("material").setup({
      style = "deep ocean", -- Deep Ocean variant
    })
    vim.cmd("colorscheme material")
  end,
})