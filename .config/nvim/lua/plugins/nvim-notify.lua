return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	cmd = "Notifications",
	opts = {
		background_colour = "#000",
		fps = 30,
		icons = {
			DEBUG = "",
			ERROR = "",
			INFO = "",
			TRACE = "",
			WARN = "",
		},
		level = 2,
		minimum_width = 50,
		render = "default",
		stages = "slide",
		timeout = 2000,
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}
