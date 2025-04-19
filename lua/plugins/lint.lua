return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      python = { "ruff" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      ["javascriptreact"] = { "eslint_d" },
      ["typescriptreact"] = { "eslint_d" },
      css = { "stylelint" },
    }

    local ruff_path = vim.fn.stdpath("data") .. "\\mason\\bin\\ruff.cmd"
    if not vim.fn.executable(ruff_path) then
      print("ruff not found")
      ruff_path = "ruff"
    end

    lint.linters.ruff = {
      cmd = "ruff",
      args = {"check", "--ouput-format=json", "--stdin-filename", "{filename}"},
      stdin = true,
      stream = "stdout",
      parser = require("lint.parser").from_errorformat(
        [[%f:%l:%c: %m]],
        { source = "ruff" }
      ),
    }
 
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
