return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      replace_netrw = true,
    },
    dashboard = {
      header = {
        "",
        "  ██████╗  ██╗  ██╗  ██████╗   ███████╗ ████████╗",
        " ██╔════╝  ██║  ██║ ██╔═══██╗  ██╔════╝  ╚═██╔══╝ ",
        " ██║  ███╗ ███████║ ██║   ██║  ███████╗    ██║   ",
        " ██║   ██║ ██╔══██║ ██║   ██║  ╚════██║    ██║   ",
        " ╚██████╔╝ ██║  ██║ ╚██████╔╝  ███████║    ██║   ",
        "  ╚═════╝  ╚═╝  ╚═╝  ╚═════╝   ╚══════╝    ╚═╝   ",
        "",
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
  },
}