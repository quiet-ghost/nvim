-- return {
--   "marko-cerovac/material.nvim",
--   lazy = false, -- Load immediately
--   priority = 1000, -- Ensure it applies early
--   config = function()
--     -- Configure Material with optional settings
--     require("material").setup({
--       contrast = {
--         terminal = true,
--         sidebars = true,
--       },
--       plugins = {
--         "dap",
--         "nvim-cmp",
--       },
--       disable = {
--         colored_cursor = false,
--         borders = false,
--       },
--       high_visibility = {
--         darker = true,
--       },
--     })

--     -- Set the Deep Ocean style
--     vim.g.material_style = "deep ocean"

--     -- Apply the colorscheme
--     vim.cmd("colorscheme material")
--   end,
-- }

return {
  "marko-cerovac/material.nvim",
  lazy = false, -- Load immediately
  priority = 1000, -- Ensure it applies early
  config = function()
    -- Configure Material with optional settings
    require("material").setup({
      contrast = {
        terminal = true,
        sidebars = true,
      },
      plugins = {
        "dap",
        "nvim-cmp",
      },
      disable = {
        colored_cursor = false,
        borders = false,
      },
      high_visibility = {
        darker = true,
      },
    })

    -- Set the Deep Ocean style as a base
    vim.g.material_style = "deep ocean"
    vim.cmd("colorscheme material")

    -- Override with Andromeda Italic colors
    -- UI Elements
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "#23262E", fg = "#D5CED9" }) -- Editor background and foreground
    -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#746f77" }) -- Line numbers
    vim.api.nvim_set_hl(0, "Visual", { bg = "#3D4352" }) -- Selection background
    vim.api.nvim_set_hl(0, "Comment", { fg = "#6d6d70", italic = true }) -- Comments (removing transparency for Neovim)
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#20232A", fg = "#D5CED9" }) -- Popup menu (e.g., completion)
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#373941" }) -- Selected item in popup
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#23262E", fg = "#D5CED9" }) -- Status bar
    vim.api.nvim_set_hl(0, "TabLine", { bg = "#23262E", fg = "#746f77" }) -- Inactive tabs
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#23262E", fg = "#00e8c6" }) -- Active tab
    vim.api.nvim_set_hl(0, "VertSplit", { fg = "#1B1D23" }) -- Window separator

    -- Syntax Highlighting (mapped from tokenColors)
    vim.api.nvim_set_hl(0, "Keyword", { fg = "#c74ded", italic = true }) -- Keywords (purple)
    vim.api.nvim_set_hl(0, "String", { fg = "#96E072" }) -- Strings (green)
    vim.api.nvim_set_hl(0, "Function", { fg = "#FFE66D" }) -- Functions (yellow)
    vim.api.nvim_set_hl(0, "Constant", { fg = "#D5CED9" }) -- Constants (foreground color)
    vim.api.nvim_set_hl(0, "Number", { fg = "#f39c12" }) -- Numbers (orange)
    vim.api.nvim_set_hl(0, "Identifier", { fg = "#D5CED9" }) -- Variables/parameters
    vim.api.nvim_set_hl(0, "Type", { fg = "#FFE66D" }) -- Types (yellow)
    vim.api.nvim_set_hl(0, "Statement", { fg = "#c74ded" }) -- Statements (purple)
    vim.api.nvim_set_hl(0, "Operator", { fg = "#ee5d43" }) -- Operators (red)
    vim.api.nvim_set_hl(0, "PreProc", { fg = "#c74ded" }) -- Preprocessor (purple)
    vim.api.nvim_set_hl(0, "Special", { fg = "#00e8c6" }) -- Special (cyan, e.g., Python source)
    vim.api.nvim_set_hl(0, "Tag", { fg = "#f92672" }) -- Tags (hot pink)
    -- vim.api.nvim_set_hl(0, "Title", { fg = "#ff00aa" }) -- Headings (pink)
    vim.api.nvim_set_hl(0, "Error", { fg = "#ee5d43" }) -- Errors (red)
    vim.api.nvim_set_hl(0, "Underlined", { fg = "#3B79C7", underline = true }) -- Links/underlined (blue)

    -- Treesitter-specific overrides (if you're using nvim-treesitter)
    vim.api.nvim_set_hl(0, "@keyword", { fg = "#c74ded", italic = true })
    vim.api.nvim_set_hl(0, "@string", { fg = "#96E072" })
    vim.api.nvim_set_hl(0, "@function", { fg = "#FFE66D" })
    vim.api.nvim_set_hl(0, "@parameter", { fg = "#9d9d9d" }) -- Parameters (from Python-specific scope)
    vim.api.nvim_set_hl(0, "@variable", { fg = "#D5CED9" })
    vim.api.nvim_set_hl(0, "@type", { fg = "#FFE66D" })
    vim.api.nvim_set_hl(0, "@constant", { fg = "#D5CED9" })
    vim.api.nvim_set_hl(0, "@number", { fg = "#f39c12" })
    vim.api.nvim_set_hl(0, "@operator", { fg = "#ee5d43" })
    vim.api.nvim_set_hl(0, "@property", { fg = "#f39c12" }) -- Object properties (orange)

    -- Terminal Colors (from terminal.ansi* in VSCode)
    vim.g.terminal_color_0 = "#23262E"  -- Black
    vim.g.terminal_color_1 = "#ee5d43"  -- Red
    vim.g.terminal_color_2 = "#96E072"  -- Green
    vim.g.terminal_color_3 = "#FFE66D"  -- Yellow
    vim.g.terminal_color_4 = "#7cb7ff"  -- Blue
    vim.g.terminal_color_5 = "#ff00aa"  -- Magenta
    vim.g.terminal_color_6 = "#00e8c6"  -- Cyan
    vim.g.terminal_color_7 = "#D5CED9"  -- White
    vim.g.terminal_color_8 = "#746f77"  -- Bright Black (gray)
    vim.g.terminal_color_9 = "#ee5d43"  -- Bright Red
    vim.g.terminal_color_10 = "#96E072" -- Bright Green
    vim.g.terminal_color_11 = "#FFE66D" -- Bright Yellow
    vim.g.terminal_color_12 = "#7cb7ff" -- Bright Blue
    vim.g.terminal_color_13 = "#ff00aa" -- Bright Magenta
    vim.g.terminal_color_14 = "#00e8c6" -- Bright Cyan
    vim.g.terminal_color_15 = "#D5CED9" -- Bright White
  end,
}