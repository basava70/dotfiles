local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "gitcommit",
		callback = function()
			vim.api.nvim_create_autocmd("BufWritePost", {
				buffer = 0,
				callback = function()
					-- Short delay to let Fugitive fully commit and update the log
					vim.defer_fn(function()
						local git_summary = vim.fn.systemlist("git log -1 --pretty=oneline --stat")

						local summary_text = table.concat(git_summary, "\n")

						vim.notify(summary_text, vim.log.levels.INFO, { title = "Git Commit Summary" })
					end, 100) -- 100ms to ensure commit completes before reading log
				end,
			})
		end,
	})
end

return M
