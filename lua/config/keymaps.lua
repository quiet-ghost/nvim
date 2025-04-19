local map = vim.keymap.set

-- General keymaps
map("n", "<leader>pv", ":Ex<CR>", { desc = "Open netrw" })
-- map("n", "<m-n>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
map("n", "<m-n>", function() Snacks.explorer() end, { desc = "Snacks Explorer" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Terminal
vim.g.terminal_buf = nil
vim.g.terminal_win = nil

map("n", "<C-_>", function()
  -- If the terminal buffer doesn't exist, create a new one
  if not vim.g.terminal_buf or not vim.api.nvim_buf_is_valid(vim.g.terminal_buf) then
    -- Open a new terminal in a horizontal split
    vim.cmd("belowright split")
    vim.cmd("terminal")
    -- Set buffer options to hide it from bufferline
    vim.api.nvim_buf_set_option(0, "buflisted", false)
    vim.api.nvim_buf_set_option(0, "bufhidden", "hide")
    -- Store the buffer and window numbers
    vim.g.terminal_buf = vim.api.nvim_get_current_buf()
    vim.g.terminal_win = vim.api.nvim_get_current_win()
    -- Resize the terminal window
    vim.cmd("resize 10")
    -- Enter insert mode
    vim.cmd("startinsert")
  else
    -- If the terminal window is open, close it
    if vim.g.terminal_win and vim.api.nvim_win_is_valid(vim.g.terminal_win) then
      vim.api.nvim_win_close(vim.g.terminal_win, true)
      vim.g.terminal_win = nil
    else
      -- Otherwise, reopen the terminal in a split
      vim.cmd("belowright split")
      vim.api.nvim_win_set_buf(0, vim.g.terminal_buf)
      vim.g.terminal_win = vim.api.nvim_get_current_win()
      vim.cmd("resize 10")
      vim.cmd("startinsert")
    end
  end
end, { desc = "Toggle terminal in horizontal split" })

map("t", "<C-_>", function()
  -- Close the terminal window but keep the buffer
  if vim.g.terminal_win and vim.api.nvim_win_is_valid(vim.g.terminal_win) then
    vim.api.nvim_win_close(vim.g.terminal_win, true)
    vim.g.terminal_win = nil
  end
end, { desc = "Hide terminal" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader><leader>", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })


-- DAP
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Continue" })
map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step into" })
map("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Step over" })
map("n", "<leader>dO", "<cmd>DapStepOut<CR>", { desc = "Step out" })
map("n", "<leader>dt", "<cmd>DapTerminate<CR>", { desc = "Terminate" })

-- Undotree
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undotree" })

-- Which-Key
map("n", "<leader>?", "<cmd>WhichKey<CR>", { desc = "Show Which-Key" })

-- LazyGit
map("n", "lg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })

-- Special keymaps
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

map("n", "<leader>s", "%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" }) -- Replace word under cursor


-- Harpoon
map("n", "<leader>a", function() require("harpoon"):list():add() end, { desc = "Add file to Harpoon" })
map("n", "<C-e>", function()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    vim.notify("Telescope not available", vim.log.levels.ERROR)
    return
  end
  local harpoon = require("harpoon")
  local conf = require("telescope.config").values
  local file_paths = {}
  for _, item in ipairs(harpoon:list().items) do
    table.insert(file_paths, item.value)
  end
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end, { desc = "Harpoon Telescope" })
map("n", "<leader>m", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, { desc = "Harpoon menu" })
map("n", "<leader>1", function() require("harpoon"):list():select(1) end, { desc = "Harpoon file 1" })
map("n", "<leader>2", function() require("harpoon"):list():select(2) end, { desc = "Harpoon file 2" })
map("n", "<leader>3", function() require("harpoon"):list():select(3) end, { desc = "Harpoon file 3" })
map("n", "<leader>4", function() require("harpoon"):list():select(4) end, { desc = "Harpoon file 4" })
map("n", "<leader>hx", function() require("harpoon"):list():clear() end, { desc = "Harpoon clear all" })
map("n", "<leader>hr", function()
  local list = require("harpoon"):list()
  if list:length() > 0 then
    local idx = tonumber(vim.fn.input("Remove index: "))
    if idx and idx > 0 and idx <= list:length() then
      list:remove_at(idx)
    end
  end
end, { desc = "Harpoon remove buffer" })
map("n", "<leader>hu", function()
  local list = require("harpoon"):list()
  local idx = tonumber(vim.fn.input("Index to move up: "))
  if idx and idx > 1 and idx <= list:length() then
    list:reorder(idx, idx - 1)
  end
end, { desc = "Harpoon move up" })
map("n", "<leader>hd", function()
  local list = require("harpoon"):list()
  local idx = tonumber(vim.fn.input("Index to move down: "))
  if idx and idx > 0 and idx < list:length() then
    list:reorder(idx, idx + 1)
  end
end, { desc = "Harpoon move down" })


-- LSP
map("n", "<leader>gd", function() require("telescope.builtin").lsp_definitions() end, { desc = "Goto Definition" })
map("n", "<leader>gr", function() require("telescope.builtin").lsp_references() end, { desc = "Goto References" })
map("n", "<leader>gI", function() require("telescope.builtin").lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "<leader>ld", function() require("telescope.builtin").lsp_type_definitions() end, { desc = "Type Definition" })
map("n", "<leader>ls", function() require("telescope.builtin").lsp_document_symbols() end, { desc = "Document Symbols" })
map("n", "<leader>lw", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, { desc = "Workspace Symbols" })
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
map({ "n", "x" }, "<leader>lc", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>lh", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
end, { desc = "Toggle Inlay Hints" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

-- Flash.nvim
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash Jump" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
map({ "n", "x", "o" }, "<leader>fs", function() require("flash").jump({ search = { mode = "search" } }) end, { desc = "Flash Search" })
map("o", "r", function() require("flash").remote() end, { desc = "Flash Remote" })

-- TODO Keys
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })

-- Bufferline
map("n", "<leader>bt", function()
  local bufferline = require("bufferline")
  local current_state = vim.g.bufferline_always_show or false
  vim.g.bufferline_always_show = not current_state
  bufferline.setup({
    options = {
      always_show_bufferline = vim.g.bufferline_always_show,
    },
  })
  if vim.g.bufferline_always_show then
    vim.notify("Bufferline always shown", vim.log.levels.INFO)
  else
    vim.notify("Bufferline shown only with multiple buffers", vim.log.levels.INFO)
  end
end, { desc = "Toggle Bufferline" })

-- Trouble.nvim
map("n", "<leader>t", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
map("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" }) -- Override previous Telescope binding
map("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics" }) -- Override previous Telescope binding
map("n", "<leader>qf", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix" })
map("n", "<leader>ll", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List" })
map("n", "<leader>lr", "<cmd>TroubleToggle lsp_references<cr>", { desc = "LSP References" }) -- Override previous rename binding
map("n", "<leader>lr", "<cmd>TroubleToggle lsp_references<cr>", { desc = "LSP References" }) -- Override previous rename binding
