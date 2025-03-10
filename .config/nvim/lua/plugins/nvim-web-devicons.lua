return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		color_icons = true,
		override = {
			[".zshrc"] = {
				icon = "", -- Use the same Zsh icon
				color = "#428850",
				cterm_color = "65",
				name = "ZshRC",
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
		override_by_filename = {
			["README.md"] = {
				icon = "",
				color = "#ffa500",
				name = "README",
			},
		},
		override_by_extension = {
			["md"] = {
				icon = "󰍔",
				color = "#ffffff",
				name = "markdown",
			},
		},
	},
}
