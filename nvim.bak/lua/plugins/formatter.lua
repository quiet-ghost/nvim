return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      python = { "black" },
      javascript = { "prettier" },
      cpp = { "clang-format" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      lua = { "stylua" },
      java = { "google-java-format" },
      ["*"] = { "trim_whitespace" }, -- Fallback for Tailwind (handled by prettier if in JS/TS)
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}