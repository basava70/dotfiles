require("core.options")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.colorscheme"),
	require("plugins.mini-icons"),
	require("plugins.neotree"),
	require("plugins.mini-animate"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.cmp"),
	require("plugins.conform"),
	require("plugins.gitsigns"),
	require("plugins.todo-comments"),
	require("plugins.lint"),
	require("plugins.vim-tmux-navigator"),
	require("plugins.which-key"),
	require("plugins.indent-blankline"),
	require("plugins.colorizer"),
	require("plugins.nvim-notify"),
})
