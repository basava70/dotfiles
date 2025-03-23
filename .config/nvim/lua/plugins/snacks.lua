return {
	"folke/snacks.nvim",
	event = "VeryLazy",
	config = function()
		require("snacks").setup({
			input = {
				border = "rounded",
				winblend = 10,
				relative = "editor",
			},
			notify = {
				backend = "snacks",
			},
			notifier = {
				backend = "snacks",
				timeout = 3000,
				integrations = {},
				kitty_method = "notify",
			},
		})
	end,
}
