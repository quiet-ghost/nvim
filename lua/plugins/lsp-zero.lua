return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    { "neovim/nvim-lspconfig" },
  },
  config = function()
    local lsp_zero = require("lsp-zero")
    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
    end) -- Added end for on_attach function

    -- LSP servers
    require("lspconfig").pyright.setup({})
    require("lspconfig").tsserver.setup({})
    require("lspconfig").clangd.setup({})
    require("lspconfig").html.setup({})
    require("lspconfig").cssls.setup({})
    require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())
    require("lspconfig").jdtls.setup({})
    require("lspconfig").tailwindcss.setup({})
  end -- End for config function
}