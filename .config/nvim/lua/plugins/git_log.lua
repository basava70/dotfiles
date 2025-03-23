-- lua/plugins/git_log.lua
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local M = {}

function M.show_git_log()
	local handle = io.popen(
		[[git log --graph --all --pretty=format:'%C(auto)%h%Creset %C(yellow)%d%Creset %s %Cgreen(%ar)%Creset %C(bold blue)%an%Creset']]
	)
	if not handle then
		vim.notify("Failed to run git log", vim.log.levels.ERROR)
		return
	end

	local output = handle:read("*a")
	handle:close()

	local entries = {}
	for line in output:gmatch("[^\r\n]+") do
		table.insert(entries, line)
	end

	pickers
		.new({}, {
			prompt_title = "Git Log Graph",
			finder = finders.new_table({
				results = entries,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry,
						ordinal = entry,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

return M
