return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lsp = {
			progress = {
				enabled = false,
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = false,
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = { "echo", "echomsg" },
				},
				view = "notify",
				opts = {
					title = "Fugitive Messages",
					merge = true,
				},
			},
		},
	},
}
