return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot-cmp" },
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false }, -- Use copilot-cmp instead
      panel = { enabled = false },
    })
    require("copilot_cmp").setup()
  end,
  -- Integrate with nvim-cmp for tab completion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        mapping = {
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
      })
    end,
  },
}