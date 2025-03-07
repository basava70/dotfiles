return {
	"lervag/vimtex", -- vimtex plugin
	config = function()
		-- Set Zathura as the PDF viewer for forward/inverse search.
		vim.g.vimtex_view_method = "zathura"

		-- Use latexmk as the compiler.
		vim.g.vimtex_compiler_method = "latexmk"

		-- Configure latexmk options (combine all options in a single table)
		vim.g.vimtex_compiler_latexmk = {
			build_dir = ".", -- Build in the current directory
			options = {
				"-pdf", -- Generate PDF output
				"-shell-escape", -- Allow shell escapes (for some packages)
				"-interaction=nonstopmode", -- Do not pause for errors
				"-synctex=1", -- Enable SyncTeX for forward/inverse search
			},
		}

		-- Enable syntax conceal for a cleaner display of math and commands.
		vim.g.vimtex_syntax_conceal = 1

		-- Automatically complete closing braces in LaTeX.
		vim.g.vimtex_complete_close_braces = 1

		-- Key mappings for common vimtex commands.
		vim.api.nvim_set_keymap("n", "<leader>ll", ":VimtexCompile<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>lv", ":VimtexView<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ld", ":VimtexStop<CR>", { noremap = true, silent = true })

		-- Enable SyncTeX forward and inverse search.
		vim.g.vimtex_view_forward_search = 1
		vim.g.vimtex_view_reverse_search = 1
	end,
}
