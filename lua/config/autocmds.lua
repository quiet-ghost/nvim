-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd("ShowkeysToggle")
--   end,
--   desc = "Auto-start showkeys on Neovim startup",
-- })
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.java",
  callback = function()
    local filename = vim.fn.expand("%:t:r")
    local lines = {
      "public class " .. filename .. " {",
      "    ",
      "}",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, { 2, 4 })
  end,
})
