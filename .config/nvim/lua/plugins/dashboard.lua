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
					icon_hl = "@variable",
					desc = "Find Files",
					group = "Lable",
					action = function()
						require("fzf-lua").files()
					end,
					key = "f",
				},
				{
					icon = "󱎸 ",
					icon_hl = "Label",
					desc = "Live Grep",
					group = "Label",
					action = function()
						require("fzf-lua").live_grep()
					end,

					key = "g",
				},
				{
					icon = " ",
					icon_hl = "Number",
					desc = "Dotfiles",
					group = "Number",
					action = function()
						require("fzf-lua").files({ cwd = vim.fn.expand("~/dotfiles/") })
					end,
					key = "d",
				},
				{
					icon = " ",
					icon_hl = "DashboardNewFile",
					desc = "New",
					group = "DashboardNewFile",
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
		-- Highlight tweaks
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#e0af68", bold = true })
				vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = "#9ece6a", bold = true })
				vim.api.nvim_set_hl(0, "DashboardFiles", { fg = "#6c6f93" })
				vim.api.nvim_set_hl(0, "DashboardNewFile", { fg = "#7AA2F7", bold = true })
			end,
		})

		-- Return to dashboard when Lazy is closed and it's the only window
		vim.api.nvim_create_autocmd("WinClosed", {
			pattern = "*",
			callback = function(args)
				local closed_buf = tonumber(args.buf)
				local ft = vim.api.nvim_buf_get_option(closed_buf, "filetype")

				if ft == "lazy" then
					vim.defer_fn(function()
						local visible_buffers = vim.tbl_filter(function(buf)
							return vim.api.nvim_buf_is_loaded(buf)
								and vim.api.nvim_buf_get_option(buf, "buflisted")
								and vim.fn.bufwinid(buf) ~= -1
						end, vim.api.nvim_list_bufs())

						if #visible_buffers == 0 then
							vim.cmd("Dashboard")
						end
					end, 50)
				end
			end,
		})

		-- Alternative approach (also works if Lazy opens and closes instantly)
		if vim.o.filetype == "lazy" then
			vim.api.nvim_create_autocmd("WinClosed", {
				pattern = tostring(vim.api.nvim_get_current_win()),
				once = true,
				callback = function()
					vim.schedule(function()
						vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
					end)
				end,
			})
		end
	end,
}
