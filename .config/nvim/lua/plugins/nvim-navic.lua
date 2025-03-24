return {
	"SmiteshP/nvim-navic",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	opts = {
		highlight = true,
		separator = "  ",
		depth_limit = 5,
		auto_attach = true,
		icons = {
			File = " ",
			Module = " ",
			Namespace = " ",
			Package = " ",
			Class = " ",
			Method = " ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = " ",
			Interface = " ",
			Function = " ",
			Variable = " ",
			Constant = " ",
			String = " ",
			Number = " ",
			Boolean = " ",
			Array = " ",
			Object = " ",
			Key = " ",
			Null = " ",
			EnumMember = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		},
	},
	config = function(_, opts)
		local navic = require("nvim-navic")
		navic.setup(opts)
		local hl = vim.api.nvim_set_hl

		-- hl(0, "NavicText", { fg = "#4fd6be", bg = "none" }) -- teal
		hl(0, "NavicText", { fg = "#ff966c", bg = "none" }) -- dark5
		-- hl(0, "NavicText", { fg = "#65bcff", bg = "none" }) -- blue1
		-- hl(0, "NavicText", { fg = "#c099ff", bg = "none" }) -- magenta
		hl(0, "NavicSeparator", { fg = "#82aaff", bg = "none" }) -- blue

		hl(0, "NavicFile", { fg = "#c8d3f5", bg = "none" }) -- fg
		hl(0, "NavicModule", { fg = "#ffc777", bg = "none" }) -- yellow
		hl(0, "NavicNamespace", { fg = "#82aaff", bg = "none" }) -- blue
		hl(0, "NavicPackage", { fg = "#c099ff", bg = "none" }) -- magenta
		hl(0, "NavicClass", { fg = "#86e1fc", bg = "none" }) -- cyan
		hl(0, "NavicMethod", { fg = "#fca7ea", bg = "none" }) -- purple
		hl(0, "NavicProperty", { fg = "#c3e88d", bg = "none" }) -- green
		hl(0, "NavicField", { fg = "#c3e88d", bg = "none" }) -- green
		hl(0, "NavicConstructor", { fg = "#fca7ea", bg = "none" }) -- purple
		hl(0, "NavicEnum", { fg = "#ff966c", bg = "none" }) -- orange
		hl(0, "NavicInterface", { fg = "#86e1fc", bg = "none" }) -- cyan
		hl(0, "NavicFunction", { fg = "#fca7ea", bg = "none" }) -- purple
		hl(0, "NavicVariable", { fg = "#c8d3f5", bg = "none" }) -- fg
		hl(0, "NavicConstant", { fg = "#ffc777", bg = "none" }) -- yellow
		hl(0, "NavicString", { fg = "#c3e88d", bg = "none" }) -- green
		hl(0, "NavicNumber", { fg = "#ff966c", bg = "none" }) -- orange
		hl(0, "NavicBoolean", { fg = "#ff757f", bg = "none" }) -- red
		hl(0, "NavicArray", { fg = "#86e1fc", bg = "none" }) -- cyan
		hl(0, "NavicObject", { fg = "#86e1fc", bg = "none" }) -- cyan
		hl(0, "NavicKey", { fg = "#ffc777", bg = "none" }) -- yellow
		hl(0, "NavicNull", { fg = "#828bb8", bg = "none" }) -- fg_dark
		hl(0, "NavicEnumMember", { fg = "#ff966c", bg = "none" }) -- orange
		hl(0, "NavicStruct", { fg = "#86e1fc", bg = "none" }) -- cyan
		hl(0, "NavicEvent", { fg = "#ff966c", bg = "none" }) -- orange
		hl(0, "NavicOperator", { fg = "#c099ff", bg = "none" }) -- magenta
		hl(0, "NavicTypeParameter", { fg = "#ff966c", bg = "none" }) -- orange

		-- Attach Navic when LSP attaches
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local bufnr = args.buf
				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end
			end,
		})

		-- Autocmd to update winbar with breadcrumbs
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved", "InsertLeave" }, {
			callback = function()
				local ignore = { "alpha", "neo-tree", "dashboard", "toggleterm", "help", "startify" }
				if vim.tbl_contains(ignore, vim.bo.filetype) then
					vim.opt_local.winbar = nil
					return
				end

				if navic.is_available() then
					vim.opt_local.winbar = "      " .. navic.get_location()
				else
					vim.opt_local.winbar = nil
				end
			end,
		})
	end,
}
