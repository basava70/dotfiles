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
				["@type.builtin"] = { italic = true }, -- int, float, etc.
				["@keyword.operator"] = { italic = true }, -- new, delete, etc.
				["@preproc"] = { italic = true }, -- #define, #include, etc.
				-- ["@comment"] = { italic = true },
				["@comment.documentation"] = { italic = true },
				["@comment.twoline"] = { italic = true },
				["@comment.tagged"] = { fg = "#eb6f92" },
				["@string"] = { italic = true },
			},
		})
		vim.cmd("colorscheme rose-pine")
		-- 		main = {
		-- 	_nc = "#16141f",
		-- 	base = "#191724",
		-- 	surface = "#1f1d2e",
		-- 	overlay = "#26233a",
		-- 	muted = "#6e6a86",
		-- 	subtle = "#908caa",
		-- 	text = "#e0def4",
		-- 	love = "#eb6f92",
		-- 	gold = "#f6c177",
		-- 	rose = "#ebbcba",
		-- 	pine = "#31748f",
		-- 	foam = "#9ccfd8",
		-- 	iris = "#c4a7e7",
		-- 	leaf = "#95b1ac",
		-- 	highlight_low = "#21202e",
		-- 	highlight_med = "#403d52",
		-- 	highlight_high = "#524f67",
		-- 	none = "NONE",
		-- },
	end,
}
