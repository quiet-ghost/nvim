return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "whoissethdaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters
        "stylua",
        "black",
        "prettierd",
        "clang-format",
        -- Linters
        "ruff",
        "eslint_d",
        "stylelint",
        -- DAPs
        "debugpy",
        "cpptools",
      },
      auto_update = true,
      run_on_start = true,
    },
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
    end,
  },
}