-- C:\Users\<YourUsername>\AppData\Local\nvim\lua\plugins\lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    -- Configure conform.nvim
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        cpp = { "clang-format" }, -- Changed from "clangd" (LSP) to formatter
        sql = { "sql-formatter" }, -- Changed from "sqlls" (LSP) to formatter
      },
    })

    -- Set up nvim-cmp
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- Set up fidget.nvim
    require("fidget").setup({})

    -- Set up mason and mason-lspconfig
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "pyright", -- Python
        "sqlls", -- SQL
        "clangd", -- C++
        "ts_ls", -- JavaScript/TypeScript
        "html", -- HTML
        "cssls", -- CSS
        "tailwindcss", -- TailwindCSS
        "lua_ls", -- Lua
      },
      handlers = {
        function(server_name) -- Default handler
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                hint = {
                  enable = true,
                  arrayIndex = "Enable",
                  setType = true,
                  paramName = "All",
                  paramType = true,
                },
              },
            },
          })
        end,
        ["pyright"] = function()
          require("lspconfig").pyright.setup({
            capabilities = capabilities,
            settings = {
              python = {
                analysis = {
                  inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                  },
                },
              },
            },
          })
        end,
        ["pylsp"] = function()
          require("lspconfig").pylsp.setup({
            capabilities = capabilities,
            settings = {
              pylsp = {
                plugins = {
                  rope_rename = { enabled = false },
                  pycodestyle = { enabled = false }, -- Disable to avoid conflicts with black
                  flake8 = { enabled = false }, -- Use conform.nvim for linting
                },
              },
            },
          })
        end,
      },
    })

    -- Configure diagnostics
    vim.diagnostic.config({
      virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR },
        source = "if_many",
        format = function(diagnostic)
          return string.format("%s: %s", diagnostic.source, diagnostic.message)
        end,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "✘",
          [vim.diagnostic.severity.WARN] = "▲",
          [vim.diagnostic.severity.HINT] = "⚑",
          [vim.diagnostic.severity.INFO] = "»",
        },
      },
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
    })

    -- Enable inlay hints globally
    vim.lsp.inlay_hint.enable(true)
  end,
}