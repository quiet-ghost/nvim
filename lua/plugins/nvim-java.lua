return {
  "nvim-java/nvim-java",
  lazy = false,
  dependencies = {
    "JavaHello/spring-boot.nvim",
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "nvim-java/nvim-java-refactor",
    "MunifTanjim/nui.nvim",
    "mfussenegger/nvim-dap",
    {
      "williamboman/mason.nvim",
      opts = {
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            capabilities = vim.lsp.protocol.make_client_capabilities(),
          },
        },
        setup = {
          jdtls = function()
            require("java").setup({
              jdk = {
                auto_install = false, -- Assuming you have JAVA_HOME set
              },
              notifications = {
                dap = false,
              },
            })
            local lspconfig = require("lspconfig")
            lspconfig.jdtls.setup({})
            return true -- Skip mason-lspconfig's default jdtls setup
          end,
        },
      },
    },
  },
}
