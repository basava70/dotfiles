local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "gitcommit",
		callback = function()
			vim.api.nvim_create_autocmd("BufWritePost", {
				buffer = 0,
				callback = function()
					local commit_message = vim.fn.join(vim.fn.readfile(vim.fn.expand("%")), " ")

					vim.notify(
						"Committed with message:\n" .. commit_message,
						vim.log.levels.INFO,
						{ title = "Git Commit" }
					)

					-- Clear the command line message right after Fugitive prints it
					vim.defer_fn(function()
						vim.cmd("echo ''")
					end, 100) -- slight delay to make sure Fugitive has already printed
				end,
			})
		end,
	})
end

return M
