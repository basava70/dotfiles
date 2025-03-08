return {
	"lervag/vimtex",
	ft = "tex",
	lazy = false,
	init = function()
		-- Ensure VimTeX uses Zathura
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_view_general_viewer = "zathura"

		-- Enable SyncTeX (Forward search: Neovim → Zathura)
		vim.g.vimtex_view_general_options = [[--synctex-forward @line:@col:@tex --unique file:@pdf\#src:@line@tex]]

		-- Other VimTeX settings
		vim.g.vimtex_quickfix_enabled = 1
		vim.g.vimtex_syntax_enabled = 1
		vim.g.vimtex_quickfix_mode = 0
		vim.g.maplocalleader = " "
	end,
}
