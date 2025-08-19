return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<M-n>"] = cmp.mapping.select_next_item(),
          ["<M-p>"] = cmp.mapping.select_prev_item(),
          ["<M-CR>"] = cmp.mapping.confirm({ select = true }),
          ["<M-e>"] = cmp.mapping.abort(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "cmdline" },
          { name = "buffer" },
          { name = "path" },
        },
      })

      -- Set up command-line completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
          { name = "luasnip" },
        }),
      })

      -- Set up search completion with highlighting
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
        view = {
          entries = { name = "wildmenu", separator = "|" },
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = "Text"
            vim_item.menu = "Search"
            return vim_item
          end,
        },
      })

      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
