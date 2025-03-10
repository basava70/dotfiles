-- Linting
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Assign linters to filetypes
		lint.linters_by_ft = {
			cpp = { "cppcheck" },
			c = { "cppcheck" },
			cuda = { "cppcheck" },
		}

		-- Auto-run linting when opening, saving, or exiting insert mode
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				if vim.bo.modifiable then
					lint.try_lint()
				end
			end,
		})
	end,
}
