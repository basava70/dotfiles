return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},

		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
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
					file_ignore_patterns = { "node_modules", ".git/", ".venv" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				find_files = {
					file_ignore_patterns = { "node_modules", ".git/", ".venv" },
					hidden = true,
				},
			},
			extensions = {
				"fzf",
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "noice")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]iles in cwd" }) -- find files within current working directory, respects .gitignore
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[O]ld files" })
		vim.keymap.set("n", "<leader>fG", builtin.git_files, { desc = "files with [G]it ls" }) -- find files within current working directory, respects .gitignore
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "[S]tring in cwd" }) -- find string in current working directory as you type
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[D]iagnostics" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[R]esume" })
		vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "[S]tring under the cursor in cwd" }) -- find string under cursor in current working directory
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[B]uffers" }) -- list open buffers in current neovim instance
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[H]elp tags" }) -- list available help tags
		vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[T]odos" }) -- find todos in the project
		vim.keymap.set("n", "<leader>f/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			}) -- find in the open files
		end, { desc = "[F]ind [/] in Open Files" })
		vim.keymap.set("n", "<leader>fn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[F]ind [N]eovim files" }) -- find in neovim files
	end,
}
