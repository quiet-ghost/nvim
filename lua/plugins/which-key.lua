return {
  "folke/which-key.nvim",
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = { spelling = true },
        win = {
          border = "rounded",
          padding = { 1, 2, 1, 2 },
        },
        layout = {
          align = "right",
          spacing = 4,
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
        },
        icons = {
          breadcrumb = "»", -- Separator for keymap paths
          separator = "➜", -- Arrow between keys and descriptions
          group = "+", -- Icon for keymap groups
        },
        show_help = true,
        show_keys = true,
        delay = 100,
      })
      wk.add({
      { "<leader>?", desc = "Show Which-Key", mode = "n" },
      { "<leader>pv", desc = "Open netrw", mode = "n" },
      { "<m-n>", desc = "Snacks Explorer", mode = "n" },
      { "<leader>D", group = "database", mode = { "n", "v" } },
      { "<leader>Db", desc = "Toggle Dadbod UI", mode = "n" },
      { "<leader>d", group = "debug", mode = { "n", "v" } },
      { "<leader>db", desc = "Toggle breakpoint", mode = "n" },
      { "<leader>dc", desc = "Continue", mode = "n" },
      { "<leader>di", desc = "Step into", mode = "n" },
      { "<leader>do", desc = "Step over", mode = "n" },
      { "<leader>dO", desc = "Step out", mode = "n" },
      { "<leader>dt", desc = "Terminate", mode = "n" },
      { "<leader>f", group = "Format current buffer", mode = { "n" } },
      { "<leader>ff", desc = "Find files", mode = "n" },
      { "<leader>fg", desc = "Live grep", mode = "n" },
      { "<leader>fb", desc = "Buffers", mode = "n" },
      { "<leader>fh", desc = "Help tags", mode = "n" },
      { "<leader>fs", desc = "Flash Search", mode = { "n", "x", "o" } },
      { "<leader>ft", desc = "Find TODOs", mode = "n" },
      { "<leader>h", group = "harpoon", mode = { "n", "v" } },
      { "<leader>a", desc = "Add file to Harpoon", mode = "n" },
      { "<leader>ht", desc = "Harpoon Telescope", mode = "n" },
      { "<leader>m", desc = "Harpoon menu", mode = "n" },
      { "<leader>1", desc = "Harpoon file 1", mode = "n" },
      { "<leader>2", desc = "Harpoon file 2", mode = "n" },
      { "<leader>3", desc = "Harpoon file 3", mode = "n" },
      { "<leader>4", desc = "Harpoon file 4", mode = "n" },
      { "<leader>hx", desc = "Harpoon clear all", mode = "n" },
      { "<leader>hr", desc = "Harpoon remove buffer", mode = "n" },
      { "<leader>hu", desc = "Harpoon move up", mode = "n" },
      { "<leader>hd", desc = "Harpoon move down", mode = "n" },
      { "<leader>e", desc = "Open netrw", mode = "n" },
      { "<leader>n", desc = "Toggle Neo-tree", mode = "n" },
      { "<leader>u", desc = "Toggle Undotree", mode = "n" },
      { "<leader>l", group = "lsp", mode = { "n", "v" } },
      { "<leader>t", group = "diagnostics", mode = "n" },
      { "<leader>tt", desc = "Toggle Trouble", mode = "n" },
      { "<leader>tw", desc = "Workspace Diagnostics", mode = "n" },
      { "<leader>td", desc = "Document Diagnostics", mode = "n" },
      { "<leader>tq", desc = "Quickfix", mode = "n" },
      { "<leader>tl", desc = "Location List", mode = "n" },
      { "<leader>tr", desc = "LSP References", mode = "n" },
      { "<leader>lw", desc = "Workspace Diagnostics", mode = "n" },
      { "<leader>ld", desc = "Document Diagnostics", mode = "n" },
      { "<leader>lq", desc = "Quickfix", mode = "n" },
      { "<leader>ll", desc = "Location List", mode = "n" },
      { "<leader>lr", desc = "LSP References", mode = "n" },
      { "<leader>ls", desc = "Document Symbols", mode = "n" },
      { "<leader>lc", desc = "Code Action", mode = { "n", "x" } },
      { "<leader>lh", desc = "Toggle Inlay Hints", mode = "n" },
      { "<leader>g", group = "git", mode = { "n", "v" } },
      { "<leader>lg", desc = "LazyGit", mode = "n" },
      { "<leader>gs", desc = "Stage Hunk", mode = { "n", "v" } },
      { "<leader>gr", desc = "Reset Hunk", mode = { "n", "v" } },
      { "<leader>gS", desc = "Stage Buffer", mode = "n" },
      { "<leader>gu", desc = "Undo Stage Hunk", mode = "n" },
      { "<leader>gR", desc = "Reset Buffer", mode = "n" },
      { "<leader>gp", desc = "Preview Hunk", mode = "n" },
      { "<leader>gb", desc = "Blame Line", mode = "n" },
      { "<leader>gt", desc = "Toggle Blame", mode = "n" },
      { "<leader>gd", desc = "Diff This", mode = "n" },
      { "<leader>gD", desc = "Diff This (Against Last Commit)", mode = "n" },
      { "<leader>gw", desc = "Toggle Word Diff", mode = "n" },
      { "<leader>b", group = "buffer", mode = "n" },
      { "<leader>bt", desc = "Toggle Bufferline", mode = "n" },
    })
    end,
  }
}

