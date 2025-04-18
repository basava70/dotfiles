return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gblame" }, -- loads on :Git etc
	event = "VimEnter", -- loads on first file read
	config = function()
		vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
		vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "[G]it [D]iff" })
		vim.keymap.set("n", "<leader>gB", ":Gblame<CR>", { desc = "[G]it [B]lame" })

		-- Fancy git log
		vim.keymap.set("n", "<leader>gl", function()
			local width = math.floor(vim.o.columns * 0.9)
			local height = math.floor(vim.o.lines * 0.85)
			local row = math.floor((vim.o.lines - height) / 2)
			local col = math.floor((vim.o.columns - width) / 2)

			local buf = vim.api.nvim_create_buf(false, true)
			local win = vim.api.nvim_open_win(buf, true, {
				relative = "editor",
				row = row,
				col = col,
				width = width,
				height = height,
				style = "minimal",
				border = "rounded",
				title = "Git Log",
				title_pos = "center",
			})
			-- Get how many lines the log will produce
			local log_lines = vim.fn.systemlist(
				[[git log --graph --all --color=always --pretty=format:'%C(auto)%h%Creset %C(yellow)%d%Creset %s %Cgreen(%ar)%Creset %C(bold blue)%an%Creset']]
			)
			if vim.v.shell_error ~= 0 then
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Git log failed." })
				return
			end
			local should_insert = #log_lines >= height - 4
			vim.api.nvim_buf_call(buf, function()
				vim.fn.termopen({
					"sh",
					"-c",
					[[git log --graph --all --color=always --pretty=format:'%C(auto)%h%Creset %C(yellow)%d%Creset %s %Cgreen(%ar)%Creset %C(bold blue)%an%Creset'; sleep 1000d]],
				})
			end)
			if should_insert then
				vim.cmd("startinsert")
			end
			-- Add this after termopen block
			vim.keymap.set({ "n", "t" }, "q", "<C-\\><C-n>:close<CR>", { buffer = buf, silent = true })
			vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:close<CR>", { buffer = buf, silent = true })
		end, { desc = "[G]it [L]og (smart terminal)" })

		-- Push branch to origin (works even if its a new branch)
		vim.keymap.set("n", "<leader>gp", function()
			local handle = io.popen("git rev-parse --abbrev-ref HEAD")
			if not handle then
				vim.notify("Failed to get current Git branch", vim.log.levels.ERROR, { title = "Git" })
				return
			end
			local branch = handle:read("*a")
			handle:close()
			if not branch or branch == "" then
				vim.notify("Git branch name is empty", vim.log.levels.ERROR, { title = "Git" })
				return
			end
			-- Clean up whitespace/newlines
			branch = branch:gsub("%s+", "")
			vim.system({ "git", "push", "--set-upstream", "origin", branch }, {
				on_exit = function(obj)
					if obj.code == 0 then
						vim.notify(obj.stdout, vim.log.levels.INFO, { title = "Git Push" })
					else
						vim.notify(obj.stderr or "Git push failed", vim.log.levels.ERROR, { title = "Git Error" })
					end
				end,
			})
		end, { desc = "[G]it [P]ush (auto upstream)" })

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
