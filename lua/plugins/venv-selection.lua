return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
  config = function()
    require('venv-selector').setup {
      anaconda_base_path = "~/ghost/anaconda3",
      anaconda_envs_path = "~/ghost/anaconda3/envs",
      cache_path = "~/.cache/venv-selector",
      -- If true, the venv selector will be automatically refreshed when you change the current directory.
      -- This is useful if you use venv-selector in a project directory.
      auto_refresh = false,
      notify_user_on_activate = true,
    }
  end,
  event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
  },
}