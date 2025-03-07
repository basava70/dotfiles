-- Collection of various small independent plugins/modules
return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		require("mini.surround").setup()

		-- Optional icons module
		require("mini.icons").setup()

		-- Indent scope visualization
		require("mini.indentscope").setup()

		-- Simple statusline
		local statusline = require("mini.statusline")
		statusline.setup({
			use_icons = vim.g.have_nerd_font,
			content = {
				location = function()
					return "%2l:%-2v"
				end,
			},
		})

		-- ✅ Mini Notify (corrected with proper format function)
		require("mini.notify").setup({
			content = {
				-- This should be a function! Example below to ensure text wraps properly.
				format = function(notif)
					return notif.msg -- Default to showing the raw message
				end,
			},
			window = {
				config = {
					relative = "editor",
					anchor = "NE",
					row = 1,
					col = vim.o.columns,
					width = math.floor(vim.o.columns * 0.35),
					border = "rounded",
				},
				winblend = 10,
			},
			lsp_progress = {
				enable = true, -- Still using fidget.nvim for this
			},
		})

		-- Replace global `vim.notify` so all notifications go through `mini.notify`
		vim.notify = require("mini.notify").make_notify()

		-- ✅ Yank notification (works with mini.notify now)
		local function get_yanked_line_count()
			local regtype = vim.v.event.regtype
			local mode = vim.fn.mode()

			if mode:match("[vV\22]") then
				-- Visual Mode (line, block, character)
				local start_pos = vim.fn.getpos("'<")
				local end_pos = vim.fn.getpos("'>")
				local line_count = math.abs(end_pos[2] - start_pos[2]) + 1

				print(string.format("[DEBUG] Visual mode yank - Lines: %d", line_count))
				return line_count
			elseif regtype:match("\22") then
				-- Visual Block Mode (Ctrl-V) - should also work via regtype
				local start_pos = vim.fn.getpos("'<")
				local end_pos = vim.fn.getpos("'>")
				local line_count = math.abs(end_pos[2] - start_pos[2]) + 1

				print(string.format("[DEBUG] Visual Block mode yank - Lines: %d", line_count))
				return line_count
			elseif regtype:match("V") then
				-- Linewise yank (normal yy or V)
				local start_pos = vim.fn.getpos("'[")
				local end_pos = vim.fn.getpos("']")
				local line_count = math.abs(end_pos[2] - start_pos[2]) + 1

				print(string.format("[DEBUG] Normal linewise yank - Lines: %d", line_count))
				return line_count
			else
				-- Character-wise yank (yw, etc.)
				print("[DEBUG] Character-wise yank detected")
				return 1
			end
		end
		vim.api.nvim_create_autocmd("TextYankPost", {
			group = vim.api.nvim_create_augroup("YankNotifyGroup", { clear = true }),
			callback = function()
				local lines = get_yanked_line_count()
				print(string.format("[DEBUG] Final calculated yanked line count: %d", lines))

				if lines > 1 then
					vim.notify(string.format("Yanked %d lines", lines), vim.log.levels.INFO)
				else
					vim.notify("Yanked 1 line", vim.log.levels.INFO)
				end
			end,
		})
	end,
}
