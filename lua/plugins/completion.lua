-- return {
--   "saghen/blink.cmp",
--   dependencies = { "rafamadriz/friendly-snippets" },
--   version = "1.*",
--   ---@module 'blink.cmp'
--   ---@type blink.cmp.Config
--   opts = {
--     keymap = { preset = "super-tab" },

--     appearance = {
--       nerd_font_variant = "mono",
--     },

--     completion = { documentation = { auto_show = false } },

--     sources = {
--       default = { "lsp", "path", "snippets", "buffer" },
--     },
--     fuzzy = { implementation = "prefer_rust_with_warning" },
--   },
--   opts_extend = { "sources.default" },
-- }

return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
      },
      ignore_filetypes = { cpp = false }, -- or { "cpp", }
      color = {
        suggestion_color = "#ffffff",
        cterm = 244,
      },
      log_level = "info", -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
      condition = function()
        return false
      end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
    })
}