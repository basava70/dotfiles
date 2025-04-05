vim.api.nvim_create_autocmd("User", {
	pattern = "FugitiveCommitPost",
	callback = function()
		local notifier = require("snacks.notifier")

		local handle = io.popen("git log -1 --pretty=format:%h\\ %s 2>/dev/null")
		local output = handle and handle:read("*a") or ""
		if handle then
			handle:close()
		end

		local trimmed = vim.trim(output)

		local level = "info"
		local icon = ""
		local msg = trimmed

		if trimmed == "" then
			level = "warn"
			icon = ""
			msg = "Empty commit or failed to retrieve message"
		elseif trimmed:lower():find("error") or trimmed:lower():find("fatal") then
			level = "error"
			icon = ""
			msg = "Git Error: " .. trimmed
		end

		notifier.new():title("Git Commit"):message(msg):icon(icon):level(level):timeout(4000):open()
	end,
})
