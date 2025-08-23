return {
  dir = "/home/ghost-desktop/dev/projects/showkeys/.worktrees/dev",
  event = "VimEnter",
  opts = {
    show_count = true,
    excluded_modes = { "i" },
    timeout = 3,
    maxkeys = 5,
    position = "bottom-center",
  },
  config = function(_, opts)
    require("showkeys").setup(opts)
    vim.cmd("ShowkeysToggle") -- Auto-start it
  end,
}
