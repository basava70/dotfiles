return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-------------------------------------------------------------
		-- Lsp stuff --
		local function getLspName()
			local buf_clients = vim.lsp.buf_get_clients()
			local buf_ft = vim.bo.filetype
			if next(buf_clients) == nil then
				return "  No servers"
			end
			local buf_client_names = {}

			for _, client in pairs(buf_clients) do
				if client.name ~= "null-ls" then
					table.insert(buf_client_names, " [" .. client.name .. "]")
				end
			end

			local lint_s, lint = pcall(require, "lint")
			if lint_s then
				for ft_k, ft_v in pairs(lint.linters_by_ft) do
					if type(ft_v) == "table" then
						for _, linter in ipairs(ft_v) do
							if buf_ft == ft_k then
								table.insert(buf_client_names, " [" .. linter .. "]")
							end
						end
					elseif type(ft_v) == "string" then
						if buf_ft == ft_k then
							table.insert(buf_client_names, ft_v)
						end
					end
				end
			end

			local ok, conform = pcall(require, "conform")
			if ok then
				for _, formatter in pairs(conform.formatters_by_ft[vim.bo.filetype]) do
					if formatter then
						table.insert(buf_client_names, "󰉠 [" .. formatter .. "]")
					end
				end
			end

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

		lualine.setup({
			sections = {
				lualine_a = {
					{
						"mode",
						icon = { "" },
					},
				},
				lualine_b = { "branch", "diff" },
				lualine_c = { "diagnostics" },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "filetype" },
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
					{ "filename" },
					{
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				lualine_z = {
					lsp,
				},
			},
		})
	end,
}
