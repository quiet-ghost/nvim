return {
  "akinsho/bufferline.nvim",
  version = "*", -- Use the latest version
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For file icons in the bufferline
  },
  event = "BufReadPost", -- Load after a buffer is read
  opts = {
    options = {
      numbers = "ordinal", -- Show buffer numbers (1, 2, 3...)
      diagnostics = "nvim_lsp", -- Integrate LSP diagnostics
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and "✘ " or level:match("warning") and "▲ " or "⚑ "
        return " " .. icon .. count
      end,
      separator_style = "slant", -- Use slanted separators
      show_buffer_close_icons = true, -- Show close icons on buffers
      show_close_icon = false, -- Hide the overall close icon
      always_show_bufferline = false, -- Only show bufferline when multiple buffers are open
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- Function to toggle bufferline visibility
    local function toggle_bufferline()
      local bufferline = require("bufferline")
      local current_state = vim.g.bufferline_always_show or false
      vim.g.bufferline_always_show = not current_state
      bufferline.setup({
        options = {
          always_show_bufferline = vim.g.bufferline_always_show,
        },
      })
      if vim.g.bufferline_always_show then
        vim.notify("Bufferline always shown", vim.log.levels.INFO)
      else
        vim.notify("Bufferline shown only with multiple buffers", vim.log.levels.INFO)
      end
    end

    -- Keybinding to toggle bufferline
    vim.keymap.set("n", "<leader>bt", toggle_bufferline, { desc = "Toggle Bufferline" })
  end,
}
