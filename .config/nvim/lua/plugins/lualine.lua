return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
				-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
			end,
		}
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
		}
		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = true,
			update_in_insert = true,
			always_visible = false,
			-- cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			-- cond = hide_in_width,
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				-- theme = 'tokyonight', -- Set theme based on environment variable
				-- Some useful glyphs:
				-- https://www.nerdfonts.com/cheat-sheet
				--        
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch", diff },
				lualine_c = { filename },
				lualine_x = {
					diagnostics,
					{ "encoding", cond = hide_in_width },
					{ "filetype", cond = hide_in_width },
				},
				lualine_y = {
					{
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				lualine_z = {
					{ "progress" },
					{ "location" },
					-- { filename },
				},
				--     function()
				--       local current_line = vim.fn.line('.')
				--       local total_lines = vim.fn.line('$')
				--       local columns = 15  -- Total length of the "track"
				--       local position = math.floor((current_line / total_lines) * columns)
				--       local line = ""
				--       for i = 0, columns do
				--         if i == position then
				--           line = line .. '⬥'  -- Diamond symbol (You can replace with ◇ or similar)
				--         else
				--           line = line .. '─'
				--         end
				--       end
				--       return line
				--     end,
				--   }
				-- },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive" },
		})
	end,
}
