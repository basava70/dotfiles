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

		-- Basic LSP progress using snacks
		vim.api.nvim_create_autocmd("LspProgress", {
			---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
			callback = function(ev)
				local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
				vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
					title = "LSP Progress",
					icon = ev.data.params.value.kind == "end" and ""
						or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1],
					replace = "lsp_progress",
				})
			end,
		})
	end,
}
