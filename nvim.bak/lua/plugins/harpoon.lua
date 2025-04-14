return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  lazy = false,
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED: Setup Harpoon
    harpoon:setup({})

    -- Basic keybindings
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
    vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to 1" })
    vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to 2" })
    vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to 3" })
    vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to 4" })

    -- Telescope integration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open Harpoon in Telescope" })

    -- New keybindings for clearing and reordering
    vim.keymap.set("n", "<leader>hx", function() harpoon:list():clear() end, { desc = "Harpoon: Clear all buffers" })
    vim.keymap.set("n", "<leader>hr", function()
      local list = harpoon:list()
      if list:length() > 0 then
        local idx = tonumber(vim.fn.input("Remove index: "))
        if idx and idx > 0 and idx <= list:length() then
          list:remove_at(idx)
        end
      end
    end, { desc = "Harpoon: Remove specific buffer" })

    -- Example: Move item up (e.g., from position 2 to 1)
    vim.keymap.set("n", "<leader>hu", function()
      local list = harpoon:list()
      local idx = tonumber(vim.fn.input("Index to move up: "))
      if idx and idx > 1 and idx <= list:length() then
        list:reorder(idx, idx - 1)
      end
    end, { desc = "Harpoon: Move buffer up" })

    -- Example: Move item down (e.g., from position 1 to 2)
    vim.keymap.set("n", "<leader>hd", function()
      local list = harpoon:list()
      local idx = tonumber(vim.fn.input("Index to move down: "))
      if idx and idx > 0 and idx < list:length() then
        list:reorder(idx, idx + 1)
      end
    end, { desc = "Harpoon: Move buffer down" })
  end,
}
