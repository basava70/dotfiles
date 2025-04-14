return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {
			win = {
				input = {
					keys = {
						["<c-n>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<c-p>"] = { "preview_scroll_up", mode = { "i", "n" } },
					},
				},
			},
			layout = "dropdown",
			layouts = {
				dropdown = {
					layout = {
						backdrop = false,
						row = 4,
						width = 0.9,
						min_width = 80,
						height = 0.9,
						border = "none",
						box = "vertical",
						{ win = "preview", title = "{preview}", height = 0.7, border = "rounded" },
						{
							box = "vertical",
							border = "rounded",
							title = "{title} {live} {flags}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
					},
				},
				vscode = {
					layout = {
						row = 0.4,
					},
				},
			},
		},
		-- indent = { enabled = true, char = "┊" },
		input = {
			border = "rounded",
			winblend = 10,
			relative = "editor",
		},
		notifier = {
			enabled = true,
		},
	},
	keys = {
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches({ all = true, layout = "select" })
			end,
			desc = "Git Branches",
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>sF",
			function()
				Snacks.picker.files({ hidden = true })
			end,
			desc = "Find Files",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.expand("~/dotfiles/") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>gD",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>sG",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep({ hidden = true })
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		-- {
		-- 	"<leader>gL",
		-- 	function()
		-- 		Snacks.picker.git_log_line()
		-- 	end,
		-- 	desc = "Git Log Line",
		-- },
		-- {
		-- 	"<leader>gS",
		-- 	function()
		-- 		Snacks.picker.git_status()
		-- 	end,
		-- 	desc = "Git Status",
		-- },
		-- { "<leader>gSs", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		{
			"<leader>gm",
			function()
				Snacks.picker.git_branches({
					all = true,
					layout = "select",
					title = "Merge Branch",
					confirm = function(picker, item)
						picker:close()
						return picker:norm(function()
							local line = item.text
							local branch = line:match("^%*?%s*([%w%-%._/]+)")
							if not branch then
								vim.notify("Could not parse branch name from: " .. line, vim.log.levels.ERROR)
								return
							end
							vim.cmd("Git merge --no-ff " .. branch)
						end)
					end,
				})
			end,
			desc = "Git merge",
		},
	},
}
