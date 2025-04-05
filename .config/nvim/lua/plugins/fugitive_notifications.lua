vim.api.nvim_create_autocmd("User", {
	pattern = "FugitiveCommitPost",
	callback = function()
		local notifier = require("snacks.notifier")

		vim.defer_fn(function()
			local handle = io.popen("git log -1 --pretty=format:[%h] %s")
			local output = handle and handle:read("*a") or "Git commit complete"
			if handle then
				handle:close()
			end

			notifier.notify(output, "info", {
				title = "Git Commit",
				icon = "",
			})
		end, 300)
	end,
})
