return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      ["javascriptreact"] = { "prettierd", "prettier" },
      ["typescriptreact"] = { "prettierd", "prettier" },
      cpp = { "clang-format" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
