return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		-- Setup Harpoon
		harpoon:setup({})

		-- Telescope integration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		-- Keymaps moved to keymaps.lua to centralize
	end,
}

