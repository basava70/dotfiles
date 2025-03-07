return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		theme = "hyper",
		config = {
			header = {
				[[███╗   ██╗ █████╗ ███╗   ██╗███╗   ██╗ █████╗ ██╗   ██╗██╗]],
				[[████╗  ██║██╔══██╗████╗  ██║████╗  ██║██╔══██╗╚██╗ ██╔╝██║]],
				[[██╔██╗ ██║███████║██╔██╗ ██║██╔██╗ ██║███████║ ╚████╔╝ ██║]],
				[[██║╚██╗██║██╔══██║██║╚██╗██║██║╚██╗██║██╔══██║  ╚██╔╝  ██║]],
				[[██║ ╚████║██║  ██║██║ ╚████║██║ ╚████║██║  ██║   ██║   ██║]],
				[[╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝   ╚═╝]],
			},
			shortcut = {
				{
					desc = "󰊳 Update",
					group = "@property", -- Use tree-sitter highlight group for some color
					action = "Lazy update",
					key = "u",
				},
				{
					icon = " ",
					icon_hl = "@variable", -- Highlight for icon (use your preferred hl group)
					desc = "Find Files",
					group = "Lable", -- Highlight for description
					action = "Telescope find_files",
					key = "f",
				},
				{
					icon = "󱎸 ",
					-- icon_hl = "@variable",
					desc = "Live Grep",
					group = "Label",
					action = "Telescope live_grep",
					key = "g",
				},
				{
					icon = " ",
					-- icon_hl = "@variable",
					desc = "Dotfiles",
					group = "Number", -- You can pick a color group you like
					action = function()
						require("telescope.builtin").find_files({
							cwd = "$HOME/dotfiles/",
						})
					end,
					key = "d",
				},
				{
					icon = "󰒲 ",
					desc = "Lazy",
					group = "@property",
					action = ":Lazy",
					key = "l",
				},
				{
					icon = " ",
					icon_hl = "@variable",
					desc = "Quit",
					group = "Error",
					action = ":qa",
					key = "q",
				},
			},
			footer = {
				"Welcome to Neovim, enjoy your session!",
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#e0af68", bold = true }) -- Orange
				vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = "#9ece6a", bold = true }) -- Green for section keys
				vim.api.nvim_set_hl(0, "DashboardFiles", { fg = "#6c6f93" }) -- DarkGray for file paths
			end,
		})
	end,
}
