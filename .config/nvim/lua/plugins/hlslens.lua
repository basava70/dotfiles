return {
	"kevinhwang91/nvim-hlslens",
	event = "CmdlineEnter",
	config = function()
		require("hlslens").setup({
			nearest_only = true,
			calm_down = true,
		})

		local kopts = { noremap = true, silent = true }

		for _, key in ipairs({ "n", "N", "*", "#", "g*", "g#" }) do
			vim.keymap.set(
				"n",
				key,
				string.format(
					[[<Cmd>execute("normal! " . v:count1 . "%s")<CR><Cmd>lua require("hlslens").start()<CR>]],
					key
				),
				kopts
			)
		end
	end,
}
