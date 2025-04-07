-- Collection of various small independent plugins/modules
return {
	"echasnovski/mini.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Better Around/Inside textobjects
		-- require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		-- require("mini.surround").setup()

		-- Optional icons module
		-- require("mini.icons").setup()

		-- Indent scope visualization
		require("mini.indentscope").setup()

		-- require("mini.animate").setup()
	end,
}
