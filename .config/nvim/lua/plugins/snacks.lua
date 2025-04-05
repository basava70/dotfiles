return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
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
			timeout = 10000,
			integrations = {},
			kitty_method = "notify",
		},
	},
}
