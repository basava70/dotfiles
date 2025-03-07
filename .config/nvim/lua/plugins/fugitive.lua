return {
	"tpope/vim-fugitive",
	config = function()
		-- Git Status
		vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })

		-- Git Diffsplit for current file
		vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "[G]it [D]iff" })

		-- Git Blame for current file
		vim.keymap.set("n", "<leader>gb", ":Gblame<CR>", { desc = "[G]it [B]lame" })
	end,
}
