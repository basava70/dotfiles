return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
			["<leader>e"] = { name = "[E]xplorer" },
			["<leader>b"] = { name = "[B]uffers", c = { name = "[C]lose" } },
			["<leader>g"] = { name = "[G]it" },
			["<leader>x"] = { name = "[T]rouble" },
			["<leader>f"] = { name = "[F]ind with Telescope" },
			["<leader>s"] = { name = "[S]tyle options" },
			["<leader>l"] = { name = "[L]azy" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
-- set keymaps
-- local wk = require("which-key")
-- wk.register({ ["<leader>"] = {
-- 	b = {
-- 		name = "[B]uffer",
-- 		c = {
-- 			name = "[C]lose",
-- 		},
-- 	},
-- } })
