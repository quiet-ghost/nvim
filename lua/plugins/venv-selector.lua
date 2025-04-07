local function shorter_name(filename)
  return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
end

return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --both are optionals for debugging
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  branch = "regexp", -- This is the regexp branch, use this for the new version
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python Venv" },
  },
  opts = {
    options = {
      -- If you put the callback here as a global option, its used for all searches (including the default ones by the plugin)
      on_telescope_result_callback = shorter_name
    },
    search = {
      my_venvs = {
        command = "fd /python$ ~/anaconda3/envs/ --full-path",
        type = "anaconda",
        -- If you put the callback here, its only called for your "my_venvs" search
        on_telescope_result_callback = shorter_name
      },
    },
  },
}