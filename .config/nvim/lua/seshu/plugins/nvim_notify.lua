return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	cmd = "Notifications",
	config = function()
		require("notify").setup({
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
		})

		vim.notify = require("notify")
	end,
}
