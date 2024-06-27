return {
	--[[ "ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		---@diagnostic disable-next-line: missing-parameter
		harpoon:setup()
		local function map(lhs, rhs, opts)
			vim.keymap.set("n", lhs, rhs, opts or {})
		end
		map("<leader>a", function()
			harpoon:list():append()
			require("notify")("Appending " .. vim.fn.expand("%t") .. "")
		end, { desc = "Append the buffer into harpoon list" })
		map("<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list(), { border = "rounded", title_pos = "center" })
		end, { desc = "Toggle harpoon quick menu" })
		for i = 1, 9 do
			map("<C-" .. i .. ">", function() -- chosse <A-i> to choose that buffer
				harpoon:list():select(i)
			end)
		end
	end, ]]
}
