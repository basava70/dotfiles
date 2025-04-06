-- Define the function BEFORE `return { ... }`
local function NewFilePrompt()
	local filename = vim.fn.input("📄 New File: ", "", "file") -- Prompt for file path
	if filename ~= "" then
		vim.cmd("edit " .. vim.fn.expand(filename)) -- Open the file at the specified path
	end
end
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
					icon = " ",
					icon_hl = "@variable", -- Highlight for icon (use your preferred hl group)
					desc = "Find Files",
					group = "Lable", -- Highlight for description
					action = "Telescope find_files",
					key = "f",
				},
				{
					icon = "󱎸 ",
					icon_hl = "Label",
					desc = "Live Grep",
					group = "Label",
					action = "Telescope live_grep",
					key = "g",
				},
				{
					icon = " ",
					icon_hl = "Number",
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
					icon = " ",
					icon_hl = "DashboardNewFile",
					desc = "New",
					group = "DashboardNewFile", -- 🔹 Apply the new highlight group
					action = function()
						NewFilePrompt()
					end,
					key = "n",
				},
				{
					icon = "󰒲 ",
					icon_hl = "@property",
					desc = "Lazy",
					group = "@property",
					action = ":Lazy",
					key = "l",
				},
				{
					icon = " ",
					icon_hl = "Error",
					desc = "Quit",
					group = "Error",
					action = ":qa",
					key = "q",
				},
			},
			footer = {
				"Nannayi always does Nannayi!",
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#e0af68", bold = true }) -- Orange
				vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = "#9ece6a", bold = true }) -- Green for section keys
				vim.api.nvim_set_hl(0, "DashboardFiles", { fg = "#6c6f93" }) -- DarkGray for file paths
				vim.api.nvim_set_hl(0, "DashboardNewFile", { fg = "#7AA2F7", bold = true }) -- 🔹 Blue for "New File"
			end,
		})
		-- Return to dashboard after Lazy (or other special buffers) close
		vim.api.nvim_create_autocmd("BufWinLeave", {
			pattern = "*",
			callback = function()
				local buftype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
				if buftype == "lazy" and #vim.api.nvim_list_bufs() == 1 then
					vim.schedule(function()
						vim.cmd("Dashboard")
					end)
				end
			end,
		})
	end,
}
