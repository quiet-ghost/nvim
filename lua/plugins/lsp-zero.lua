return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
  },
  config = function()
    local lsp_zero = require("lsp-zero")
    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
    end)

    -- LSP servers for all languages
    require("lspconfig").pyright.setup({})          -- Python
    require("lspconfig").tsserver.setup({})         -- JavaScript/TypeScript
    require("lspconfig").clangd.setup({})           -- C++
    require("lspconfig").html.setup({})             -- HTML
    require("lspconfig").cssls.setup({})            -- CSS
    require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls()) -- Lua
    require("lspconfig").jdtls.setup({})            -- Java
    require("lspconfig").tailwindcss.setup({})      -- Tailwind CSS
  end,
}