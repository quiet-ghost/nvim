vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = false
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.isfname:append("@-@")
vim.opt.colorcolumn = "80"


-- Python setup
local conda_prefix = os.getenv("CONDA_PREFIX")
if conda_prefix and conda_prefix ~= "" then
  vim.g.python_host_prog = conda_prefix .. "/bin/python"
  vim.g.python3_host_prog = conda_prefix .. "/bin/python"
else
  vim.g.python_host_prog = "python"
  vim.g.python3_host_prog = "python3"
end

-- Terminal setup
local function setup_terminal()
  local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
  if is_windows then
    vim.opt.shell = [["C:/Program Files/Git/bin/bash.exe"]]
    vim.opt.shellcmdflag = "-c"
    vim.opt.shellxquote = ""
  else
    vim.opt.shell = "/bin/zsh"
    vim.opt.shellcmdflag = "-c"
    vim.opt.shellxquote = "'"
  end
end

setup_terminal()
