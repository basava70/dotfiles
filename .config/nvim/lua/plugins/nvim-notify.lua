-- return {
-- 	"rcarriga/nvim-notify",
-- 	opts = {
-- 		stages = "fade",
-- 		timeout = 3000,
-- 		background_colour = "#000000",
-- 	},
-- 	init = function()
-- 		vim.notify = require("notify") -- Set global notify after plugin loads
-- 	end,
-- }
return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	cmd = "Notifications",
	opts = {
		-- background_colour = "#000",
		fps = 90,
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
	init = function()
		vim.notify = require("notify") -- Set global notify after plugin loads
	end,
}
