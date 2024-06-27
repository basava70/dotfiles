return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")

		ls.setup({
			-- Enable autotriggered snippets
			enable_autosnippets = true,

			-- repeated events
			update_events = "TextChanged,TextChangedI",

			-- Use Tab (or some other key if you prefer) to trigger visual selection
			store_selection_keys = "<Tab>",
		})
		vim.cmd([[
        " Use Tab to expand
        imap <silent><expr> kk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'kk'
        smap <silent><expr> kk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'kk'
    ]])
	end,
}
