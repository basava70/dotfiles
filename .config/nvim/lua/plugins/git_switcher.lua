-- lua/plugins/git_switcher.lua
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")
local conf = require("telescope.config").values

local M = {}

local function get_git_refs()
	local refs = {}

	-- Get local branches
	local branch_handle = io.popen("git for-each-ref --format='%(refname:short)' refs/heads/")

	if branch_handle then
		for line in branch_handle:lines() do
			table.insert(refs, { kind = "branch", value = line, label = " " .. line })
		end
		branch_handle:close()
	end

	-- Get tags
	local tag_handle = io.popen("git tag")
	if tag_handle then
		for line in tag_handle:lines() do
			table.insert(refs, { kind = "tag", value = line, label = "🔖 " .. line })
		end
		tag_handle:close()
	end

	-- Get last 20 commits
	local log_handle = io.popen("git log --pretty=format:'%h %s' -n 20")
	if log_handle then
		for line in log_handle:lines() do
			local hash, msg = line:match("^(%w+)%s+(.+)$")
			if hash and msg then
				table.insert(
					refs,
					{ kind = "commit", value = hash, label = "󰊢 " .. hash .. " " .. msg, hash = hash, msg = msg }
				)
			end
		end
		log_handle:close()
	end

	return refs
end

function M.git_switcher()
	local results = get_git_refs()

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 2 }, -- icon
			{ width = 12 }, -- short ref or hash
			{ remaining = true }, -- description
		},
	})

	pickers
		.new({}, {
			prompt_title = "Git Checkout",
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					return {
						value = entry.value,
						ordinal = entry.value,
						display = function()
							if entry.kind == "commit" then
								return displayer({
									{ "󰊢", "TelescopeResultsIdentifier" },
									{ entry.hash, "TelescopeResultsIdentifier" },
									{ entry.msg, "Comment" },
								})
							else
								return displayer({
									{ entry.kind == "branch" and "" or "🔖", "TelescopeResultsFunction" },
									{ entry.value, "TelescopeResultsIdentifier" },
									{ "", "" },
								})
							end
						end,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr) -- pass prompt_bufnr here
					if selection then
						vim.cmd("Git checkout " .. selection.value)
					end
				end)
				return true
			end,
		})
		:find()
end

return M
