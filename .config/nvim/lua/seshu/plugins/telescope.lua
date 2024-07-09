return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				live_grep = {
					file_ignore_patterns = { "node_modules", ".git", ".venv" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				find_files = {
					file_ignore_patterns = { "node_modules", ".git", ".venv" },
					hidden = true,
				},
			},
			extensions = {
				"fzf",
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		-- local wk = require("which-key")
		-- wk.register({ ["<leader>"] = {
		-- 	s = {
		-- 		name = "[S]earch using Telescope",
		-- 	},
		-- } })

		keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "[F]iles in cwd" }) -- find files within current working directory, respects .gitignore
		keymap.set("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "[O]ld files" })
		keymap.set("n", "<leader>sG", "<cmd>Telescope git_files<cr>", { desc = "files with [G]it ls" }) -- find files within current working directory, respects .gitignore
		keymap.set("n", "<leader>ss", "<cmd>Telescope live_grep<cr>", { desc = "[S]tring in cwd" }) -- find string in current working directory as you type
		keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "[D]iagnostics" })
		keymap.set("n", "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "[R]esume" })
		keymap.set("n", "<leader>sc", "<cmd>Telescope grep_string<cr>", { desc = "[S]tring under the cursor in cwd" }) -- find string under cursor in current working directory
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[B]uffers" }) -- list open buffers in current neovim instance
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "[H]elp tags" }) -- list available help tags
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[T]odos" }) -- find todos in the project
	end,
}
