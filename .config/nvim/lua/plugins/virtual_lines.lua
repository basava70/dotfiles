-- ~/.config/nvim/lua/plugins/diagnostics.lua

-- Show virtual lines for current line and virtual text everywhere else
vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = { current_line = true },
	underline = true,
	severity_sort = true,
	update_in_insert = false,
})

-- Hide virtual text on the current line to avoid clutter
local og_virt_text = nil
local og_virt_line = vim.diagnostic.config().virtual_lines

vim.api.nvim_create_autocmd({ "CursorMoved", "DiagnosticChanged" }, {
	group = vim.api.nvim_create_augroup("diagnostic_only_virtlines", {}),
	callback = function()
		if not og_virt_line or not og_virt_line.current_line then
			if og_virt_text then
				vim.diagnostic.config({ virtual_text = og_virt_text })
				og_virt_text = nil
			end
			return
		end

		if not og_virt_text then
			og_virt_text = vim.diagnostic.config().virtual_text
		end

		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
		local diagnostics = vim.diagnostic.get(0, { lnum = lnum })

		if vim.tbl_isempty(diagnostics) then
			vim.diagnostic.config({ virtual_text = og_virt_text })
		else
			vim.diagnostic.config({ virtual_text = false })
		end
	end,
})

-- Force redraw diagnostics on mode switch (e.g., insert -> normal)
vim.api.nvim_create_autocmd("ModeChanged", {
	group = vim.api.nvim_create_augroup("diagnostic_redraw", {}),
	callback = function()
		pcall(vim.diagnostic.show)
	end,
})
