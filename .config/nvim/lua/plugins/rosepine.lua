-- lua/plugins/rose-pine.lua
return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			disable_italics = true,
			highlight_groups = {
				["@keyword.conditional"] = { italic = true }, -- if, else
				["@keyword.repeat"] = { italic = true }, -- for, while
				["@keyword.return"] = { italic = true }, -- return
				["@keyword.type"] = {
					italic = true,
					fg = "#eb6f92", -- custom color for 'auto', 'const', etc.
				},
				-- ["@type.builtin"] = { italic = true }, -- int, float, etc.
				["@keyword.operator"] = { italic = true }, -- new, delete, etc.
				["@preproc"] = { italic = true }, -- #define, #include, etc.
				-- ["@comment"] = { italic = true },
				["@comment.documentation"] = { italic = true },
				["@comment.twoline"] = { italic = true },
				["@comment.tagged"] = { fg = "#eb6f92" },
			},
		})

		vim.cmd("colorscheme rose-pine")
	end,
}
