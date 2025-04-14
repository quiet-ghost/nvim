return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<Tab>",
				},
				ignore_filetypes = { cpp = false }, -- or { "cpp" }
				color = {
					suggestion_color = "#6d6d70",
					cterm = 244,
				},
				log_level = "info", -- set to "off" to disable logging completely
				disable_inline_completion = false, -- disables inline completion for use with cmp
				disable_keymaps = false, -- disables built-in keymaps for more manual control
				condition = function()
					return false
				end,
			})
		end,
	},
}
