return {
	"folke/tokyonight.nvim",
	priority = 1000, -- Load before other plugins
	config = function()
		-- Import the theme setup
		local tokyonight = require("tokyonight")

		-- Variable to track transparency state
		local bg_transparent = false

		-- Function to toggle transparency
		local function toggle_transparency()
			bg_transparent = not bg_transparent -- Toggle state

			-- Reapply the colorscheme with "night" style and updated transparency
			tokyonight.setup({
				style = "moon", -- Ensure the theme stays in "night" mode
				transparent = bg_transparent,
				styles = {
					comments = { italic = false },
					sidebars = bg_transparent and "transparent" or "default",
					floats = bg_transparent and "transparent" or "default",
				},
			})

			-- Reload the colorscheme
			vim.cmd("colorscheme tokyonight-moon")

			-- Debugging: Print state in the command line
			print("Transparency set to:", bg_transparent)
		end

		-- Initial setup of colorscheme
		tokyonight.setup({
			style = "moon", -- Use "night" theme variant
			transparent = bg_transparent,
			styles = {
				comments = { italic = false },
				sidebars = "transparent",
				floats = "transparent",
			},
		})

		-- Apply the colorscheme initially
		vim.cmd("colorscheme tokyonight-moon")

		-- Keybinding to toggle transparency
		vim.keymap.set(
			"n",
			"<leader>bg",
			toggle_transparency,
			{ noremap = true, silent = true, desc = "Toggle Transparency" }
		)
	end,
}
