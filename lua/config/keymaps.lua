-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
--
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "File Explorer" }) -- Open file explorer

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" }) -- Move selected lines down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" }) -- Move selected lines up

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" }) -- Join lines and keep cursor position
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" }) -- Scroll down and center
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" }) -- Scroll up and center
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" }) -- Next search result and center
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" }) -- Previous search result and center

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" }) -- Paste without overwriting register

vim.keymap.set("n", "<leader>y", [["+y]], { desc = "Yank to system clipboard" }) -- Yank to system clipboard
vim.keymap.set("v", "<leader>y", [["+y]], { desc = "Yank to system clipboard" }) -- Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to system clipboard (line)" }) -- Yank to system clipboard (line)

vim.keymap.set("n", "<leader>d", [["_d]], { desc = "Delete without overwriting register" }) -- Delete without overwriting register
vim.keymap.set("v", "<leader>d", [["_d]], { desc = "Delete without overwriting register" }) -- Delete without overwriting register

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" }) -- Exit insert mode

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q" }) -- Disable Q

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "tmux sessionizer" }) -- tmux sessionizer
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format current buffer" }) -- Format current buffer

vim.keymap.set(
  "n",
  "<leader>s",
  "%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Replace word under cursor" }
) -- Replace word under cursor

vim.keymap.set("n", "<C-k>", "<C-w> k")
vim.keymap.set("n", "<C-j>", "<C-w> j")
vim.keymap.set("n", "<C-h>", "<C-w> h")
vim.keymap.set("n", "<C-l>", "<C-w> l")
