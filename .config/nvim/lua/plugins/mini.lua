-- Collection of various small independent plugins/modules
return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		-- require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		-- require("mini.surround").setup()

		-- Optional icons module
		-- require("mini.icons").setup()

		-- Indent scope visualization
		require("mini.indentscope").setup()

		-- Simple statusline
		-- local statusline = require("mini.statusline")
		-- statusline.setup({
		-- 	use_icons = vim.g.have_nerd_font,
		-- 	content = {
		-- 		location = function()
		-- 			return "%2l:%-2v"
		-- 		end,
		-- 	},
		-- })

		-- require("mini.animate").setup()

		-- -- ✅ Mini Notify (corrected with proper format function)
		-- require("mini.notify").setup({
		-- 	content = {
		-- 		-- This should be a function! Example below to ensure text wraps properly.
		-- 		format = function(notif)
		-- 			return notif.msg -- Default to showing the raw message
		-- 		end,
		-- 	},
		-- 	window = {
		-- 		config = {
		-- 			relative = "editor",
		-- 			anchor = "NE",
		-- 			row = 1,
		-- 			col = vim.o.columns,
		-- 			width = math.floor(vim.o.columns * 0.35),
		-- 			border = "rounded",
		-- 		},
		-- 		winblend = 10,
		-- 	},
		-- 	lsp_progress = {
		-- 		enable = true, -- Still using fidget.nvim for this
		-- 	},
		-- })

		-- Replace global `vim.notify` so all notifications go through `mini.notify`
		-- vim.notify = require("mini.notify").make_notify()
	end,
}
