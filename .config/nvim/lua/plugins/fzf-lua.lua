return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	dependencies = { "echasnovski/mini.icons" },
	opts = {
		grep = { hidden = true },
		winopts = {
			height = 0.85,
			width = 0.85,
			row = 0.35,
			col = 0.5,
			border = "rounded",
			preview = {
				border = "rounded",
				layout = "vertical", -- or "horizontal"
				vertical = "up:60%", -- or "down:60%"
			},
		},
		fzf_colors = {
			true, -- inherit fzf colors that aren't specified below from
			-- the auto-generated theme similar to `fzf_colors=true`
			["fg"] = { "fg", "CursorLine" },
			["bg"] = { "bg", "Normal" },
			["hl"] = { "fg", "Comment" },
			["fg+"] = { "fg", "Normal", "underline" },
			["bg+"] = { "bg", { "CursorLine", "Normal" } },
			["hl+"] = { "fg", "Statement" },
			["info"] = { "fg", "PreProc" },
			["prompt"] = { "fg", "Conditional" },
			["pointer"] = { "fg", "Exception" },
			["marker"] = { "fg", "Keyword" },
			["spinner"] = { "fg", "Label" },
			["header"] = { "fg", "Comment" },
			["gutter"] = "-1",
		},
	},
	keys = {
		{
			"<leader>sf",
			function()
				require("fzf-lua").files()
			end,
			desc = "[S]earch [F]iles",
		},
		{
			"<leader>sg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "[S]earch by [G]rep",
		},
		{
			"<leader>sc",
			function()
				require("fzf-lua").files({ cwd = vim.fn.expand("~/dotfiles/") })
			end,
			desc = "[S]earch in [C]onfig (dotfiles)",
		},
		{
			"<leader>sh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "[S]earch [H]elp",
		},
		{
			"<leader>sk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "[S]earch [K]eymaps",
		},
		{
			"<leader>sb",
			function()
				require("fzf-lua").builtin()
			end,
			desc = "[S]earch [B]uiltin FZF",
		},
		{
			"<leader>sw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "[S]earch current [W]ord",
		},
		{
			"<leader>sW",
			function()
				require("fzf-lua").grep_cWORD()
			end,
			desc = "[S]earch current [W]ORD",
		},
		{
			"<leader>sd",
			function()
				require("fzf-lua").diagnostics_document()
			end,
			desc = "[S]earch [D]iagnostics",
		},
		{
			"<leader>sr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "[S]earch [R]esume",
		},
		{
			"<leader>so",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "[S]earch [O]ld Files",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "[,] search existing buffers",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "[/] Live grep the current buffer",
		},
	},
}
