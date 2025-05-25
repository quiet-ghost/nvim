return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional: for slash commands
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: improves vim.ui.select
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          xai = function()
            return require("codecompanion.adapters").extend("xai", {
              env = {
                api_key = os.getenv("XAI_API_KEY"),
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = "xai" },
          inline = { adapter = "xai" },
          agent = { adapter = "xai" },
        },
        display = {
          chat = {
            window = {
              layout = "vertical", -- Side panel
              width = 0.3, -- Narrower window (30% of editor width)
              border = "rounded", -- Prettier border
            },
            show_settings = true, -- Show model settings
            show_token_count = true, -- Show token count
            start_in_insert_mode = true, -- Start in insert mode
            buf_type = "markdown", -- Fixed: Use correct buffer type
          },
        },
      })
      -- Ensure proper filetype and rendering for CodeCompanion buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "codecompanion",
        callback = function()
          vim.bo.filetype = "codecompanion"
          vim.bo.syntax = "markdown"
          vim.wo.conceallevel = 2
          vim.wo.concealcursor = "n" -- Show concealed text in normal mode
        end,
      })
    end,
  },
}
