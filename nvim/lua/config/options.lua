-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Helper function to check if a value is empty
local function isempty(s)
  return s == nil or s == ""
end

-- Helper function to use a fallback if the primary value is undefined
local function use_if_defined(primary, fallback)
  return isempty(primary) and fallback or primary
end

-- Check if an environment is active at startup
local conda_prefix = os.getenv("CONDA_PREFIX")
if not isempty(conda_prefix) then
  -- Use the active Conda environment if one is set
  vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, conda_prefix .. "/bin/python")
  vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, conda_prefix .. "/bin/python")
else
  -- Defer to VenvSelector by not setting a default; it will handle this
  -- Optionally set a fallback system Python if VenvSelector isn't used
  vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, "python")
  vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, "python3")
end

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
