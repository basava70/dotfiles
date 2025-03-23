return {
	"folke/snacks.nvim",
	event = "VeryLazy",
	opts = {
		-- optional: customize only the input UI
		input = {
			border = "rounded",
			winblend = 10,
			relative = "editor",
		},
		-- Add notifier to handle advanced notifications
		notify = {
			backend = "snacks", -- Use snacks' own stylish notify
		},
		notifier = {
			-- Optional: you can set default configurations for notifier here
			-- Customize any part of the notifier UI as needed
			timeout = 3000, -- Example: Set the timeout for notifications (in milliseconds)
		},
	},
}
