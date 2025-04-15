return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      -- Enable flash for regular search (/)
      search = {
        enabled = true,
      },
      -- Enable flash for char motions (e.g., f, t, F, T)
      char = {
        enabled = true,
      },
    },
    label = {
      -- Show labels in uppercase for better visibility
      uppercase = true,
      -- Show labels after the match (not before)
      after = true,
      before = false,
    },
  },
  keys = {
    -- Jump to any word in the buffer
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
    -- Jump using tree-sitter nodes (e.g., functions, classes)
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- Flash-enhanced search (integrates with /)
    { "<leader>fs", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search" } }) end, desc = "Flash Search" },
    -- Remote operations (e.g., yank/delete in operator-pending mode)
    { "r", mode = "o", function() require("flash").remote() end, desc = "Flash Remote" },
  },
}
