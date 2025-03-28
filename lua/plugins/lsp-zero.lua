return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    {"neovim/nvim-lspconfig"},
    {"hrsh7th/nvim-cmp"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"L3MON4D3/LuaSnip"},
  },
  config = function()
    local lsp_zero = require("lsp-zero")
    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({buffer = bufnr})
    end)
    -- Example LSP servers (add more as needed)
    require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())
    require("lspconfig").pyright.setup({})
  end,
}