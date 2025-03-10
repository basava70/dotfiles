return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		override = {
			[".zshrc"] = {
				icon = "", -- Use the same Zsh icon
				color = "#428850",
				cterm_color = "65",
				name = "ZshRC",
			},
			["README.md"] = {
				icon = "",
				color = "#ffa500",
				name = "README",
			},
			["CMakelists.txt"] = {
				icon = "",
				color = "#ffa500",
				name = "CMakelists",
			},
			["Makefile"] = {
				icon = "",
				color = "#1abc9c",
				name = "Makefile",
			},
			["cmake"] = {
				icon = "",
				color = "#ffa500",
				name = "cmakeicon",
			},
			["cc"] = {
				icon = "󰙲",
				color = "#7AA2F7",
				name = "cppicon",
			},
			["cpp"] = {
				icon = "󰙲",
				color = "#7AA2F7",
				name = "cppicon",
			},
			["log"] = {
				icon = "󰺿",
				color = "#81e043",
				name = "Log",
			},
		},
		color_icons = true,
		-- -- default = true,
		-- strict = true,
	},
}

-- return {
-- 	"nvim-tree/nvim-web-devicons",
-- 	opts = {
--
-- 		override = {
-- 			zsh = {
-- 				icon = "",
-- 				color = "#428850",
-- 				cterm_color = "65",
-- 				name = "Zsh",
-- 			},
-- 		},
-- 		-- globally enable different highlight colors per icon (default to true)
-- 		-- if set to false all icons will have the default icon's color
-- 		color_icons = true,
-- 		-- globally enable default icons (default to false)
-- 		-- will get overriden by `get_icons` option
-- 		default = true,
-- 		-- globally enable "strict" selection of icons - icon will be looked up in
-- 		-- different tables, first by filename, and if not found by extension; this
-- 		-- prevents cases when file doesn't have any extension but still gets some icon
-- 		-- because its name happened to match some extension (default to false)
-- 		strict = true,
-- 		-- set the light or dark variant manually, instead of relying on `background`
-- 		-- (default to nil)
-- 		variant = "light|dark",
-- 		-- same as `override` but specifically for overrides by filename
-- 		-- takes effect when `strict` is true
-- 		override_by_filename = {
-- 			[".gitignore"] = {
-- 				icon = "",
-- 				color = "#f1502f",
-- 				name = "Gitignore",
-- 			},
-- 			["CMakelists.txt"] = {
-- 				icon = "",
-- 				-- color = "#ffa500",
-- 				name = "CMakelists",
-- 			},
-- 			["README.md"] = {
-- 				icon = "",
-- 				color = "#ffa500",
-- 				name = "README",
-- 			},
-- 		},
-- 		-- same as `override` but specifically for overrides by extension
-- 		-- takes effect when `strict` is true
-- 		override_by_extension = {
-- 			["cmake"] = {
-- 				icon = "",
-- 				color = "#1abc9c",
-- 				name = "cmakeicon",
-- 			},
-- 			["cc"] = {
-- 				icon = "󰙲",
-- 				color = "#7AA2F7",
-- 				name = "cppicon",
-- 			},
-- 			["cpp"] = {
-- 				icon = "󰙲",
-- 				color = "#7AA2F7",
-- 				name = "cppicon",
-- 			},
-- 			["log"] = {
-- 				icon = "󰺿",
-- 				color = "#81e043",
-- 				name = "Log",
-- 			},
-- 		},
-- 		-- same as `override` but specifically for operating system
-- 		-- takes effect when `strict` is true
-- 		override_by_operating_system = {
-- 			["apple"] = {
-- 				icon = "",
-- 				color = "#A2AAAD",
-- 				cterm_color = "248",
-- 				name = "Apple",
-- 			},
-- 		},
-- 	},
-- }
