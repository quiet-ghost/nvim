return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = function()
        -- Use cmake for cross-platform compatibility
        local function is_windows()
          return vim.loop.os_uname().sysname:find("Windows") ~= nil
        end

        if is_windows() then
          -- On Windows, use cmake with MinGW Makefiles
          return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
        else
          -- On Unix-like systems, use make
          return "make"
        end
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- Enable fuzzy matching
          override_generic_sorter = true, -- Override Telescope's generic sorter
          override_file_sorter = true, -- Override Telescope's file sorter
          case_mode = "smart_case", -- Use smart case for matching
        },
      },
    })
    -- Load fzf extension
    pcall(telescope.load_extension, "fzf")
  end,
}
