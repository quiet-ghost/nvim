return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot-cmp" },
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true }, -- Disable built-in suggestions (use copilot-cmp)
      panel = { enabled = false },      -- Disable panel
      filetypes = {
        ["*"] = true,                  -- Enable for all filetypes
      },
    })
    require("copilot_cmp").setup()
    require("copilot.suggestion").is_visible()
    require("copilot.suggestion").accept(modifier)
    require("copilot.suggestion").accept_word()
    require("copilot.suggestion").accept_line()
    require("copilot.suggestion").next()
    require("copilot.suggestion").prev()
    require("copilot.suggestion").dismiss()
    require("copilot.suggestion").toggle_auto_trigger()
    -- Integrate with nvim-cmp
  end,
}