return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Extend LazyVim's default opts
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "python",
      "javascript",
      "cpp",
      "typescript",
      "html",
      "css",
      "lua",
      "java",
      "tsx", -- For Tailwind in TSX
    })
    opts.highlight = { enable = true }
    opts.incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<C-s>",
        node_decremental = "<C-backspace>",
      },
    }
    opts.indent = { enable = true }
  end,
}