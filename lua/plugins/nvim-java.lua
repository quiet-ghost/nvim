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
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      config = function()
        require("dapui").setup()
      end,
    },
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
            local mason_registry = require("mason-registry")
            local bundles = {
              vim.fn.glob(
                mason_registry.get_package("java-debug-adapter"):get_install_path() .. "/extension/server/*.jar"
              ),
              vim.fn.glob(mason_registry.get_package("java-test"):get_install_path() .. "/extension/server/*.jar"),
            }
            -- Detect SDKMAN or system JDKs
            local java_home = os.getenv("JAVA_HOME")
              or vim.fn.getenv("SDKMAN_DIR")
                and vim.fn.glob(vim.fn.getenv("SDKMAN_DIR") .. "/candidates/java/current")
            local java_exec = java_home and (java_home .. "/bin/java") or "java"
            require("java").setup({
              jdk = {
                auto_install = true,
                path = java_exec,
              },
              notifications = {
                dap = true,
              },
            })
            local lspconfig = require("lspconfig")
            lspconfig.jdtls.setup({
              init_options = {
                bundles = bundles,
              },
              settings = {
                java = {
                  configuration = {
                    runtimes = {
                      {
                        name = "JavaSE-17",
                        path = vim.fn.glob("/usr/lib/jvm/java-17-openjdk")
                          or vim.fn.glob(vim.fn.getenv("SDKMAN_DIR") .. "/candidates/java/17.0.8-tem"), -- Adjust paths
                        default = true,
                      },
                      {
                        name = "JavaSE-21",
                        path = vim.fn.glob("/usr/lib/jvm/java-21-openjdk")
                          or vim.fn.glob(vim.fn.getenv("SDKMAN_DIR") .. "/candidates/java/21.0.7-tem"), -- Adjust paths
                        default = false,
                      },
                      {
                        name = "JavaSE-24",
                        path = vim.fn.glob("/usr/lib/jvm/java-24-openjdk")
                          or vim.fn.glob(vim.fn.getenv("SDKMAN_DIR") .. "/candidates/java/24.0.1-tem"),
                      },
                    },
                  },
                },
              },
            })
            -- Configure DAP for Java
            local dap = require("dap")
            dap.configurations.java = {
              {
                type = "java",
                request = "launch",
                name = "Launch Java",
                mainClass = "${fileBasenameNoExtension}",
                classPaths = { vim.fn.getcwd() },
                javaExec = java_exec, -- Use detected JDK
                projectName = "${fileBasenameNoExtension}",
              },
              {
                type = "java",
                request = "attach",
                name = "Debug (Attach) - Remote",
                hostName = "127.0.0.1",
                port = 1326,
              },
            }
            return true -- Skip mason-lspconfig's default jdtls setup
          end,
        },
      },
    },
  },
}
