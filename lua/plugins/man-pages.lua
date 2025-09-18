return {
  "quiet-ghost/man-pages.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("man-pages").setup({
      keymaps = {
        search = "<leader>mp", -- Search for a specific man page
        browse = "<leader>mb", -- Browse all man pages
      },
    })
  end,
}
