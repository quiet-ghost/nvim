return {
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-completion",
	"kristijanhusak/vim-dadbod-ui",
	vim.keymap.set("n", "<leader>db", ":DB<CR>", { noremap = true, silent = true }),
	vim.keymap.set("n", "<leader>dB", ":DBUI<CR>", { noremap = true, silent = true }),
}
