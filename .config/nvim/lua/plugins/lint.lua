-- Linting
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			markdown = { "markdownlint-cli2" },
			latex = { "chktex", "vale" },
			text = { "vale" },
			python = { "ruff" },
			c = { "clang-tidy", "cppcheck" },
			cpp = { "clang-tidy", "cppcheck" },
			cuda = { "clang-tidy", "cppcheck" },
		}

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
