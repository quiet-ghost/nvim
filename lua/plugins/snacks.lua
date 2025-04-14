return {
	"folke/snacks.nvim",
	event = "InsertEnter",
	config = function()
		require("snacks").setup({})
	end,
}
