-- plugins/noice.lua
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},

		-- ✅ Add custom routes here
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "", -- regular echo output
					find = "%[.*%]", -- matches "[main abc123]" style commit lines
				},
				opts = {
					title = "Git Commit",
					icon = "",
					level = vim.log.levels.INFO,
				},
			},
		},
	},

	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "rcarriga/nvim-notify", -- optional
	},
}
