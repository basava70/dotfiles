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
					vim.opt_local.winbar = navic.get_location()
				else
					vim.opt_local.winbar = nil
				end
			end,
		})
	end,
}
