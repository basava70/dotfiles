return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-------------------------------------------------------------
		-- Lsp stuff --
		local function getLspName()
			local buf_clients = vim.lsp.get_clients()
			local buf_ft = vim.bo.filetype
			if next(buf_clients) == nil then
				return "  No servers"
			end
			local buf_client_names = {}

			for _, client in pairs(buf_clients) do
				if client.name ~= "null-ls" then
					table.insert(buf_client_names, "  [" .. client.name .. "]")
				end
			end

			-- local lint_s, lint = pcall(require, "lint")
			-- if lint_s then
			-- 	for ft_k, ft_v in pairs(lint.linters_by_ft) do
			-- 		if type(ft_v) == "table" then
			-- 			for _, linter in ipairs(ft_v) do
			-- 				if buf_ft == ft_k then
			-- 					table.insert(buf_client_names, " [" .. linter .. "]")
			-- 				end
			-- 			end
			-- 		elseif type(ft_v) == "string" then
			-- 			if buf_ft == ft_k then
			-- 				table.insert(buf_client_names, ft_v)
			-- 			end
			-- 		end
			-- 	end
			-- end

			-- local ok, conform = pcall(require, "conform")
			-- if ok then
			-- 	for _, formatter in pairs(conform.formatters_by_ft[vim.bo.filetype]) do
			-- 		if formatter then
			-- 			table.insert(buf_client_names, "󰉠 [" .. formatter .. "]")
			-- 		end
			-- 	end
			-- end

			local hash = {}
			local unique_client_names = {}

			for _, v in ipairs(buf_client_names) do
				if not hash[v] then
					unique_client_names[#unique_client_names + 1] = v
					hash[v] = true
				end
			end
			local language_servers = table.concat(unique_client_names, " ")

			return language_servers
		end

		local lsp = {
			function()
				return getLspName()
			end,
		}
		-------------------------------------------------------------

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
		--
		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = true,
			update_in_insert = true,
			always_visible = false,
		}
		--
		local diff = {
			"diff",
			symbols = { added = "+", modified = "~", removed = "-" },
		}
		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
			end,
		}

		lualine.setup({
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
				lualine_x = {
					diagnostics,
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_y = {
					{ "location" },
					{
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				lualine_z = {
					lsp,
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
		})
	end,
}
