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
    "theHamsta/nvim-dap-virtual-text",
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      config = function()
        require("dapui").setup()
        require("nvim-dap-virtual-text").setup({
          enabled = true, -- Enable the plugin
          enabled_commands = true, -- Create commands like :DapVirtualTextEnable
          highlight_changed_variables = true, -- Highlight changed variables
          highlight_new_as_changed = true, -- Highlight new variables as changed
          show_stop_reason = true, -- Show why DAP stopped (e.g., breakpoint)
          commented = false, -- Show virtual text as comments (e.g., // value)
          virt_text_pos = "eol", -- Position of virtual text ("eol" or "inline")
          all_frames = false, -- Show virtual text for all stack frames
          virt_lines = false, -- Use virtual lines instead of virtual text
          virt_text_win_col = nil, -- Set to a number to fix column position
        })
      end,
    },
    {
      "williamboman/mason.nvim",
      opts = {
        registries = {
          "github:mason-org/mason-registry",
          "github:nvim-java/mason-registry",
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
            local sdkman_dir = os.getenv("SDKMAN_DIR")
            local java_home = os.getenv("JAVA_HOME")
            if not java_home and sdkman_dir then
              local sdkman_java = vim.fn.glob(sdkman_dir .. "/candidates/java/current")
              if sdkman_java and sdkman_java ~= "" then
                java_home = sdkman_java
              end
            end
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
                        path = "/usr/lib/jvm/java-17-openjdk",
                        default = true,
                      },
                      {
                        name = "JavaSE-21",
                        path = "/usr/lib/jvm/java-21-openjdk",
                        default = false,
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
                classPaths = { "${workspaceFolder}", vim.fn.getcwd() },
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
