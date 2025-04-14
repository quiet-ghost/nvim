local lazy = require("lazy")

lazy.setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "plugins" },
  },
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "tarPlugin", "netrwPlugin" },
    },
  },
  rocks = {
    enabled = false, -- Disable luarocks entirely
  },
})