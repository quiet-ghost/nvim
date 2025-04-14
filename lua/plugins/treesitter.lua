return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		ensure_installed = {
			"lua",
			"python",
			"sql",
			"cpp",
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",
			"markdown",
		},
		highlight = { enable = true },
		indent = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
