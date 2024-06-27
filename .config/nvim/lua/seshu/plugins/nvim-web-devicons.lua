return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		local nvim_web_devicons = require("nvim-web-devicons")
		nvim_web_devicons.set_icon({
			cu = {
				icon = "",
				color = "#447028",
				cterm_color = "22",
				-- color = "#6d8086",
				-- color = "#526064",
				-- color = "#f34b7d",
				name = "Cuda",
			},
			["F90"] = {
				icon = "󱈚",
				color = "#734f96",
				cterm_color = "97",
				name = "Fortran",
			},
		})
	end,
}
