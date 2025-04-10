local fzf = require("fzf-lua")

-- Custom highlight groups (define your own colors if needed)
vim.api.nvim_set_hl(0, "GitCommitIcon", { fg = "#f7768e" })
vim.api.nvim_set_hl(0, "GitRemoteBranchIcon", { fg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "GitRemoteBranchText", { fg = "#0db9d7" })
vim.api.nvim_set_hl(0, "GitLocalBranchIcon", { fg = "#41a6b5" })
vim.api.nvim_set_hl(0, "GitLocalBranchText", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "GitAheadBehind", { fg = "#e0af68" })

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

	local branch_handle = io.popen("git for-each-ref --format='%(refname:short)' refs/heads/")
	if branch_handle then
		for line in branch_handle:lines() do
			local_branches[line] = true
			table.insert(refs, { label = "󰘬 " .. line, value = line, kind = "local" })
		end
		branch_handle:close()
	end

	local remote_handle = io.popen("git for-each-ref --format='%(refname:short)' refs/remotes/origin/")
	if remote_handle then
		for line in remote_handle:lines() do
			local remote = line
			local local_name = remote:gsub("^origin/", "")
			if not local_branches[local_name] then
				table.insert(refs, { label = "󰑔 " .. remote, value = remote, kind = "remote" })
			else
				local differs, annotation = is_branch_different(local_name, remote)
				if differs then
					table.insert(refs, {
						label = "󰑔 " .. remote .. (annotation or ""),
						value = remote,
						kind = "remote",
					})
				end
			end
		end
		remote_handle:close()
	end

	local log_handle = io.popen("git log --all --pretty=format:'%h|%cr|%s'")
	if log_handle then
		for line in log_handle:lines() do
			local hash, reltime, msg = line:match("^(%w+)|([^|]+)|(.+)$")
			if hash and msg then
				table.insert(refs, {
					label = string.format(" %s 󰥔 %s %s", hash, reltime, msg),
					value = hash,
					kind = "commit",
				})
			end
		end
		log_handle:close()
	end

	return refs
end

function M.git_checkout()
	local refs = get_git_refs()
	local entries = {}
	for _, entry in ipairs(refs) do
		table.insert(entries, entry.label)
	end

	fzf.fzf_exec(entries, {
		prompt = "Git Checkout> ",
		previewer = "builtin",
		preview = "git show --color=always {1}",
		winopts = {
			title = " Git Checkout",
			preview = { layout = "vertical", vertical = "up:65%" },
		},
		actions = {
			["default"] = function(selected)
				local line = selected[1]
				if not line then
					return
				end

				local remote = line:match("^󰑔 (%S+)")
				local commit = line:match("^ (%S+)")
				local local_branch = line:match("^󰘬 (%S+)")

				if remote then
					local local_name = remote:gsub("^origin/", "")
					vim.cmd("Git checkout -b " .. local_name .. " " .. remote)
				elseif commit then
					vim.cmd("Git checkout " .. commit)
				elseif local_branch then
					vim.cmd("Git checkout " .. local_branch)
				end
			end,
		},
	})
end

return M
