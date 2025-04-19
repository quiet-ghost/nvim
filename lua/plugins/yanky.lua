return {
	"gbprod/yanky.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		highlight = { timer = 150 },
	},
	config = function(_, opts)
		require("yanky").setup(opts)
		vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
		vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
		vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
		vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
	end,
}
