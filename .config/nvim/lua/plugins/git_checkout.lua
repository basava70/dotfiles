local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")
local Job = require("plenary.job")

-- Set up custom highlights for Git UI
vim.api.nvim_set_hl(0, "GitCommitIcon", { fg = "#f7768e" }) -- commit icon
vim.api.nvim_set_hl(0, "GitRemoteBranchIcon", { fg = "#7aa2f7" }) -- remote icon
vim.api.nvim_set_hl(0, "GitRemoteBranchText", { fg = "#0db9d7" }) -- remote text (cyan)
vim.api.nvim_set_hl(0, "GitLocalBranchIcon", { fg = "#41a6b5" }) -- local icon
vim.api.nvim_set_hl(0, "GitLocalBranchText", { fg = "#9ece6a" }) -- local text (green)
vim.api.nvim_set_hl(0, "GitAheadBehind", { fg = "#41a6b5" }) -- orange

local M = {}

local function is_branch_different(local_branch, remote_branch)
	local cmd = string.format("git rev-list --left-right --count %s...%s", remote_branch, local_branch)
	local handle = io.popen(cmd)
	if not handle then
		return false, nil
	end
	local result = handle:read("*a"):gsub("%s+", "")
	handle:close()
	if result == "00" then
		return false, nil
	end
	local ahead, behind = result:match("(%d+)(%d+)")
	return true, string.format(" [%s↑ %s↓]", ahead, behind)
end

local function get_git_refs()
	local refs = {}
	local local_branches = {}

	-- Get local branches
	local branch_handle = io.popen("git for-each-ref --format='%(refname:short)' refs/heads/")
	if branch_handle then
		for line in branch_handle:lines() do
			local_branches[line] = true
			table.insert(refs, { kind = "branch", value = line, label = "󰘬 " .. line })
		end
		branch_handle:close()
	end

	-- Get remote branches and check for divergence
	local remote_handle = io.popen("git for-each-ref --format='%(refname:short)' refs/remotes/origin/")
	if remote_handle then
		for line in remote_handle:lines() do
			local remote = line
			local local_name = remote:gsub("^origin/", "")
			if not local_branches[local_name] then
				table.insert(refs, { kind = "remote", value = remote, label = "󰑔 " .. remote })
			else
				local differs, annotation = is_branch_different(local_name, remote)
				if differs then
					table.insert(refs, {
						kind = "remote",
						value = remote,
						label = "󰑔 " .. remote .. (annotation or ""),
						annotation = annotation,
					})
				end
			end
		end
		remote_handle:close()
	end

	-- Get all commits
	local log_handle = io.popen("git log --pretty=format:'%h %s'")
	if log_handle then
		for line in log_handle:lines() do
			local hash, msg = line:match("^(%w+)%s+(.+)$")
			if hash and msg then
				table.insert(refs, {
					kind = "commit",
					value = hash,
					label = " " .. hash .. " " .. msg,
					hash = hash,
					msg = msg,
				})
			end
		end
		log_handle:close()
	end

	return refs
end

function M.git_checkout()
	local results = get_git_refs()

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 2 },
			{ width = 30 },
			{ remaining = true },
		},
	})

	pickers
		.new({}, {
			prompt_title = "Git Checkout",
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					local ord = entry.kind == "commit" and (entry.hash .. " " .. entry.msg) or entry.value
					return {
						value = entry.value,
						kind = entry.kind,
						ordinal = ord,
						display = function()
							if entry.kind == "commit" then
								return displayer({
									{ "", "GitCommitIcon" },
									{ entry.hash, "TelescopeResultsNumber" },
									{ entry.msg, "TelescopeResultsComment" },
								})
							elseif entry.kind == "tag" then
								return displayer({
									{ "", "TelescopeResultsConstant" },
									{ entry.value, "TelescopeResultsString" },
									{ "", "" },
								})
							elseif entry.kind == "remote" then
								return displayer({
									{ "󰑔", "GitRemoteBranchIcon" },
									{ entry.value, "GitRemoteBranchText" },
									{ entry.annotation or "", "GitAheadBehind" },
								})
							else
								return displayer({
									{ "󰘬", "GitLocalBranchIcon" },
									{ entry.value, "GitLocalBranchText" },
									{ "", "" },
								})
							end
						end,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry)
					local cmd = { "git", "show", entry.value }
					Job:new({
						command = cmd[1],
						args = { unpack(cmd, 2) },
						on_exit = function(j)
							vim.schedule(function()
								if not self.state then
									return
								end
								vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, j:result())
								vim.bo[self.state.bufnr].filetype = "diff" -- 🌈 add syntax highlighting
							end)
						end,
					}):start()
				end,
			}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection then
						if selection.kind == "remote" then
							local local_name = selection.value:gsub("^origin/", "")
							vim.cmd("Git checkout -b " .. local_name .. " " .. selection.value)
						else
							vim.cmd("Git checkout " .. selection.value)
						end
					end
				end)
				return true
			end,
		})
		:find()
end

return M
