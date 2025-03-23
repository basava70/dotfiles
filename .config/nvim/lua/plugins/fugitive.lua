return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
		vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "[G]it [D]iff" })
		vim.keymap.set("n", "<leader>gb", ":Gblame<CR>", { desc = "[G]it [B]lame" })

		-- Push branch to origin (works even if its a new branch)
		vim.keymap.set("n", "<leader>gp", function()
			local handle = io.popen("git rev-parse --abbrev-ref HEAD")
			if not handle then
				vim.notify("Failed to get current Git branch", vim.log.levels.ERROR)
				return
			end

			local branch = handle:read("*a")
			handle:close()

			if not branch or branch == "" then
				vim.notify("Git branch name is empty", vim.log.levels.ERROR)
				return
			end

			-- Clean up whitespace/newlines
			branch = branch:gsub("%s+", "")

			vim.cmd("Git push --set-upstream origin " .. branch)
		end, { desc = "[G]it [P]ush (auto upstream)" })

		-- Create a new branch
		vim.keymap.set("n", "<leader>gb", function()
			vim.ui.input({ prompt = "New branch name: " }, function(branch)
				if branch ~= nil and branch ~= "" then
					vim.cmd("Git checkout -b " .. branch)
				end
			end)
		end, { desc = "[G]it checkout -[b] (new branch)" })

		-- Git merge
		vim.keymap.set("n", "<leader>gm", function()
			-- Get local branches
			local handle = io.popen("git for-each-ref --format='%(refname:short)' refs/heads/")
			local output = handle and handle:read("*a") or ""
			if handle then
				handle:close()
			end

			local branches = {}
			for line in output:gmatch("[^\r\n]+") do
				table.insert(branches, line)
			end

			vim.ui.select(branches, { prompt = "Merge branch into current:" }, function(choice)
				if choice and choice ~= "" then
					vim.cmd("Git merge --no-ff " .. choice)
				end
			end)
		end, { desc = "[G]it [M]erge branch into current" })

		-- Create augroup to namespace this autocmd
		local group = vim.api.nvim_create_augroup("FugitiveCloseStatusBuffer", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = "fugitive",
			callback = function()
				vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true })
			end,
		})
	end,
}
