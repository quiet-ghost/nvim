-- return {
--   "linux-cultist/venv-selector.nvim",
--   dependencies = {
--     "neovim/nvim-lspconfig",
--     "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
--     { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
--   },
--   lazy = false,
--   branch = "regexp", -- This is the regexp branch, use this for the new version
--   keys = {
--     { "<leader>v", "<cmd>VenvSelect<cr>" },
--   },
--   ---@type venv-selector.Config
--   opts = {
--     -- Your settings go here
--   },
-- }

return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
  opts = {
    anaconda_base_path = "~/anaconda3",       -- Tell VenvSelector where to look for Anaconda installations
    anaconda_envs_path = "~/anaconda3/envs",  -- Tell VenvSelector where to look for Anaconda environments
    search_venvs = { "~/anaconda3/envs" },    -- Tell VenvSelector to look in ~/anaconda3/envs/
    conda = true,                             -- Enable Conda support (if available in your version)
    notify_user_on_activate = true,         -- Optional: Notify when an env is selected
  },
  keys = {
    { "<leader>v", "<cmd>VenvSelect<cr>", desc = "Select Virtual Environment" },
  },
}