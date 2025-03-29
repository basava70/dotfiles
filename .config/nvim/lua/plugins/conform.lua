-- Autoformat
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				cuda = { "clang_format" },
				tex = { "latexindent" },
				bibtex = { "bibtex-tidy" },
				sh = { "shfmt" },
				yaml = { "prettier" },
			},
			formatters = {
				clang_format = {
					command = "clang-format",
					prepend_args = {
						"-style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never, \
						AccessModifierOffset: 0, IndentAccessModifiers: true, \
						PackConstructorInitializers: Never}",
					},
				},
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
		})

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
