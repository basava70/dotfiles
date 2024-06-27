return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				transparent = true,
				style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			})
			-- setup must be called before loading
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
