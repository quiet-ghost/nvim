return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()

    vim.g.copilot_filetypes = { ["*"] = true }
  end,
}