return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
			end,
		}

		local lazy_status = require("lazy.status")

		local function file_icon_with_name()
			local devicons = require("nvim-web-devicons")
			local fname = vim.fn.expand("%:t") -- Get filename
			local ext = vim.fn.expand("%:e") -- Get file extension
			local icon, icon_color = devicons.get_icon_color(fname, ext, { default = true })

			if fname == "" then
				return "" -- If there's no filename, return empty
			end

			-- Apply the correct color to the icon
			local icon_hl = "%#LualineFileIcon#" -- Default highlight group for icon
			if icon_color then
				-- Define a highlight group dynamically
				local hl_group = "LualineFileIcon_" .. ext
				vim.api.nvim_set_hl(0, hl_group, { fg = icon_color, bg = "none" })
				icon_hl = "%#" .. hl_group .. "#"
			end

			-- Return the icon (with color) + filename
			return icon_hl .. (icon or "") .. " %#Normal#" .. fname
		end

		-- local filename = {
		-- 	"filename",
		-- 	file_status = true,
		-- 	path = 0,
		-- }

		-- local hide_in_width = function()
		-- 	return vim.fn.winwidth(0) > 100
		-- end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = true,
			update_in_insert = true,
			always_visible = false,
		}

		local diff = {
			"diff",
			symbols = { added = "+", modified = "~", removed = "-" },
		}

		-- Setup Lualine
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "tokyonight",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch", diff },
				lualine_c = { file_icon_with_name },
				lualine_x = { diagnostics },
				lualine_y = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				lualine_z = {
					{ "location" },
					function()
						local current_line = vim.fn.line(".")
						local total_lines = vim.fn.line("$")
						local columns = 15
						local position = math.floor((current_line / total_lines) * columns)
						local line = ""
						for i = 0, columns do
							if i == position then
								line = line .. "⬥"
							else
								line = line .. "─"
							end
						end
						return line
					end,
				},
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

		-- === Force Transparent Background for Lualine ===
		local function make_lualine_transparent()
			local sections = { "c", "x" } -- { "a", "b", "c", "x", "y", "z" }
			local modes = { "normal", "insert", "visual", "replace", "command", "inactive" }

			for _, hl_mode in ipairs(modes) do
				for _, section in ipairs(sections) do
					local hl_name = "lualine_" .. section .. "_" .. hl_mode
					local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = hl_name })

					if ok then
						vim.api.nvim_set_hl(0, hl_name, {
							fg = hl.fg,
							bg = "none", -- Transparent
							sp = hl.sp,
							underline = hl.underline,
							bold = hl.bold,
							italic = hl.italic,
						})
					end
				end
			end
		end

		-- Run this after every colorscheme change to ensure lualine gets reset
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = make_lualine_transparent,
		})

		-- Apply transparency immediately (for first launch)
		make_lualine_transparent()
	end,
}
