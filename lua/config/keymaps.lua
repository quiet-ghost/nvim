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

-- Java Running
map("n", "<leader>jr", "<cmd>JavaRunnerRunMain<CR>", { desc = "Run Java Main" })
map("n", "<leader>jrs", "<cmd>JavaRunnerStopMain<CR>", { desc = "Stop Java Main" })
map("n", "<leader>jrl", "<cmd>JavaRunnerToggleLogs<CR>", { desc = "Toggle Java Runner Logs" })

-- Java Testing
map("n", "<leader>jtc", "<cmd>JavaTestRunCurrentClass<CR>", { desc = "Run Current Test Class" })
map("n", "<leader>jtm", "<cmd>JavaTestRunCurrentMethod<CR>", { desc = "Run Current Test Method" })
map("n", "<leader>jtdc", "<cmd>JavaTestDebugCurrentClass<CR>", { desc = "Debug Current Test Class" })
map("n", "<leader>jtdm", "<cmd>JavaTestDebugCurrentMethod<CR>", { desc = "Debug Current Test Method" })
map("n", "<leader>jtr", "<cmd>JavaTestViewLastReport<CR>", { desc = "View Last Test Report" })

-- Java DAP
map("n", "<leader>jd", "<cmd>JavaDapConfig<CR>", { desc = "Configure Java DAP" })

-- Java Refactoring
map("n", "<leader>jrv", "<cmd>JavaRefactorExtractVariable<CR>", { desc = "Extract Variable" })
map("n", "<leader>jrc", "<cmd>JavaRefactorExtractConstant<CR>", { desc = "Extract Constant" })
map("n", "<leader>jrm", "<cmd>JavaRefactorExtractMethod<CR>", { desc = "Extract Method" })
map("n", "<leader>jrf", "<cmd>JavaRefactorExtractField<CR>", { desc = "Extract Field" })

-- Java Build
map("n", "<leader>jbb", "<cmd>JavaBuildBuildWorkspace<CR>", { desc = "Build Workspace" })
map("n", "<leader>jbc", "<cmd>JavaBuildCleanWorkspace<CR>", { desc = "Clean Workspace" })

-- Java Settings
map("n", "<leader>jsr", "<cmd>JavaSettingsChangeRuntime<CR>", { desc = "Change Java Runtime" })

-- Java Profiles
map("n", "<leader>jp", "<cmd>JavaProfile<CR>", { desc = "Java Profiles" })

-- DAP keymaps
map("n", "<F2>", "<cmd>DapContinue<CR>", { desc = "DAP Continue" })
map("n", "<C-b>", "<cmd>DapToggleBreakpoint<CR>", { desc = "DAP Toggle Breakpoint" })
map("n", "<leader>ds", "<cmd>DapStepOver<CR>", { desc = "DAP Step Over" })
map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "DAP Step Into" })
map("n", "<leader>do", "<cmd>DapStepOut<CR>", { desc = "DAP Step Out" })
map("n", "<F1>", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle DAP UI" })

-- References Notes
map("n", "<leader>jn", function()
  require("telescope.builtin").live_grep({
    search_dirs = { "~/Github/Notes/References/Java/JavaNote.md" },
    prompt_title = "Search JavaNote.md",
  })
end, { desc = "Search JavaNote.md" })
map("n", "<leader>pn", function()
  require("telescope.builtin").live_grep({
    search_dirs = { "~/Github/Notes/References/Python/PythonNote.md" },
    prompt_title = "Search PythonNote.md",
  })
end, { desc = "Search PythonNote.md" })
map("n", "<leader>cpp", function()
  require("telescope.builtin").live_grep({
    search_dirs = { "~/Github/Notes/References/C++/CppNote.md" },
    prompt_title = "Search CppNote.md",
  })
end, { desc = "Search CppNote.md" })
map("n", "<leader>sql", function()
  require("telescope.builtin").live_grep({
    search_dirs = { "~/Github/Notes/References/MySQL/MySQLNote.md" },
    prompt_title = "Search MySQLNote.md",
  })
end, { desc = "Search MySQLNote.md" })
