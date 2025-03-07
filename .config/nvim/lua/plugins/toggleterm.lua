return {
	"akinsho/toggleterm.nvim",
	version = "*", -- You can pin to a specific version or use latest
	opts = {
		open_mapping = [[<leader>t]], -- Set keymap to open/close terminal
		direction = "float", -- Use floating terminal
		float_opts = {
			border = "rounded", -- Optional: rounded borders
			winblend = 0, -- Transparency (0 = opaque)
		},
		shade_terminals = true, -- Give terminal a darker background
		shading_factor = 2,
		start_in_insert = true, -- Immediately enter insert mode when opening
		persist_size = true,
		persist_mode = true,
		close_on_exit = true, -- Close terminal buffer when process exits
	},
}
