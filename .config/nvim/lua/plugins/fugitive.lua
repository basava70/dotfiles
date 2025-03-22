return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
		vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "[G]it [D]iff" })
		vim.keymap.set("n", "<leader>gb", ":Gblame<CR>", { desc = "[G]it [B]lame" })
		vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "[G]it [P]ush" })

		vim.keymap.set("n", "<leader>gb", function()
			vim.ui.input({ prompt = "New branch name: " }, function(branch)
				if branch ~= nil and branch ~= "" then
					vim.cmd("Git checkout -b " .. branch)
				end
			end)
		end, { desc = "[G]it checkout -[b] (new branch)" })

		-- Create augroup to namespace this autocmd
		local group = vim.api.nvim_create_augroup("FugitiveCloseStatusBuffer", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = "fugitive",
			callback = function()
				vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true })
			end,
		})
	end,
}
