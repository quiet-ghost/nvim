return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	opts = {
		filesystem = {
			follow_current_file = { enabled = true },
			hijack_netrw_behavior = "open_current",
		},
	},
}
