return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      python = { "flake8" },
      javascript = { "eslint_d" },
      cpp = { "cpplint" },
      typescript = { "eslint_d" },
      html = { "htmlhint" },
      css = { "stylelint" },
      lua = { "luacheck" },
      java = { "checkstyle" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}