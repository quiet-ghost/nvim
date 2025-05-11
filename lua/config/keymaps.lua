local map = vim.keymap.set

-- General keymaps
map("n", "<leader>pv", ":Ex<CR>", { desc = "Open netrw" })
map("n", "<m-n>", function()
  Snacks.explorer()
end, { desc = "Snacks Explorer" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

--- Special keymaps
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" }) -- Move selected lines down
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" }) -- Move selected lines up

map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" }) -- Join lines and keep cursor position
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" }) -- Scroll down and center
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" }) -- Scroll up and center
map("n", "n", "nzzzv", { desc = "Next search result and center" }) -- Next search result and center
map("n", "N", "Nzzzv", { desc = "Previous search result and center" }) -- Previous search result and center

map("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" }) -- Paste without overwriting register

map("n", "<leader>y", [["+y]], { desc = "Yank to system clipboard" }) -- Yank to system clipboard
map("v", "<leader>y", [["+y]], { desc = "Yank to system clipboard" }) -- Yank to system clipboard
map("n", "<leader>Y", [["+Y]], { desc = "Yank to system clipboard (line)" }) -- Yank to system clipboard (line)

map("n", "<leader>d", [["_d]], { desc = "Delete without overwriting register" }) -- Delete without overwriting register
map("v", "<leader>d", [["_d]], { desc = "Delete without overwriting register" }) -- Delete without overwriting register

map("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" }) -- Exit insert mode

map("n", "Q", "<nop>", { desc = "Disable Q" }) -- Disable Q

map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "tmux sessionizer" }) -- tmux sessionizer
map("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format current buffer" }) -- Format current buffer

map("n", "<leader>s", "%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" }) -- Replace word under cursor- Keymaps are automatically loaded on the VeryLazy event

-- TODO Keys
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })

-- Undotree
map("n", "<C-n>", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undotree" })

-- CodeCompanion keymaps
map("n", "<leader>aa", "<cmd>CodeCompanionChat<CR>", { desc = "Open CodeCompanion chat" })
map("n", "<leader>ap", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion actions palette" })
map("v", "<leader>ae", "<cmd>CodeCompanion explain<CR>", { desc = "Explain selected code" })
map("v", "<leader>af", "<cmd>CodeCompanion fix<CR>", { desc = "Fix selected code" })
map("v", "<leader>ar", "<cmd>CodeCompanion refactor<CR>", { desc = "Refactor selected code" })

-- CodeCompanion chat buffer keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "codecompanion",
  callback = function()
    map("n", "<C-s>", "<cmd>CodeCompanionSave<CR>", { buffer = true, desc = "Save chat buffer" })
    map("n", "q", "<cmd>CodeCompanionClose<CR>", { buffer = true, desc = "Close chat buffer" })
  end,
})

-- CodeCompanion Code Actions
map("v", "<leader>cx", "<cmd>CodeCompanion fix<CR>", { desc = "Fix selected code" })
map("v", "<leader>ct", "<cmd>CodeCompanion tests<CR>", { desc = "Generate tests for selected code" })

-- Telescope keymaps
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find text" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find help" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Find old files" })
map("n", "<leaderfs", "<cmd>Telescope git_status<CR>", { desc = "Find git status" })
map("n", "<leader>gd", "<cmd>Telescope builtin goto_definition<CR>", { desc = "Find definition" })
map("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", { desc = "Find references" })
map("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Find implementations" })
map("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Find type definitions" })
map("n", "<leader>gd", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Find document symbols" })
