return {
	"rcarriga/nvim-notify",
	opts = {
		stages = "fade",
		timeout = 3000,
		background_colour = "#000000",
	},
	init = function()
		vim.notify = require("notify") -- Set global notify after plugin loads
	end,
}
