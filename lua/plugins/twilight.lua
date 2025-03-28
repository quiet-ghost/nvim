return {
  "folke/twilight.nvim",
  opts = {
    dimming = { alpha = 0.25 }, -- Dimming opacity
    context = 10,               -- Lines of context to keep visible
  },
  -- Load lazily but ensure it's ready on startup
  lazy = false,
  config = function()
    -- Enable Twilight right after plugin setup
    require("twilight").setup() -- Apply opts
    require("twilight").enable() -- Turn it on
  end,
}