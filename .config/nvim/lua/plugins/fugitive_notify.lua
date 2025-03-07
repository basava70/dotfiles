local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "gitcommit",
		callback = function()
			vim.api.nvim_create_autocmd("BufWritePost", {
				buffer = 0,
				callback = function()
					local commit_message = table.concat(vim.fn.readfile(vim.fn.expand("%")), "\n")

					-- Capture git's post-commit summary (like files changed, insertions, deletions)
					local git_summary = vim.fn.systemlist("git log -1 --stat")

					local combined_message = "Committed with message:\n"
						.. commit_message
						.. "\n\n"
						.. table.concat(git_summary, "\n")

					vim.notify(combined_message, vim.log.levels.INFO, { title = "Git Commit" })
				end,
			})
		end,
	})
end

return M
