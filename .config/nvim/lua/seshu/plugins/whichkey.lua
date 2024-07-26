return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		-- Document existing key chains
		require("which-key").add({
			{ "<leader>f", group = "[F]ind with Telescope" },
			{ "<leader>b", group = "[B]uffers" },
			{ "<leader>g", group = "[G]it", icon = "" },
			{ "<leader>x", group = "[T]rouble" },
			{ "<leader>l", group = "[L]azy" },
			{ "<leader>s", group = "[S]tyle options" },
		})
		require("which-key").setup()
	end,
}
