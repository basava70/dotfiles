return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }

			-- set keybinds
			keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", { desc = "[F]inder" }) -- show definition, references
			-- keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
			keymap.set("n", "gP", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "peek type [D]efinition" }) -- got to declaration
			keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "peek [d]efinition" }) -- see definition and make edits in window
			keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "[G]oto [d]efinition" })
			keymap.set("n", "gD", "<cmd>Lspsaga goto_type_definition<CR>", { desc = "[G]oto type [D]efinition" })
			keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "lsp buf [i]mplementation" }) -- go to implementation
			keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "code action" }) -- see available code actions
			keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "line [D]iagnostics" }) -- show  diagnostics for line
			keymap.set("n", "<leader>D", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "cusror [D]iagnostics" }) -- show diagnostics for cursor
			keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "prev [D]iagnostic" }) -- jump to previous diagnostic in buffer
			keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "next [D]iagnostic" }) -- jump to next diagnostic in buffer
			keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			-- single_file_support = false,
			on_attach = function(client, bufnr)
				client.server_capabilities.signatureHelpProvider = false
				on_attach(client, bufnr)
			end,
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
		})

		-- python
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				pyright = {
					disableOrganizeImports = false,
					analysis = {
						useLibraryCodeForTypes = true,
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						autoImportCompletions = true,
					},
				},
			},
		})

		lspconfig["texlab"].setup({
			capabilities = capabilities,
			single_file_support = false,
			on_attach = on_attach,
			settings = {
				texlab = {
					auxDirectory = ".",
					-- bibtexFormatter = "bibtex-tidy",
					build = {
						args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
						executable = "latexmk",
						forwardSearchAfter = false,
						onSave = false,
					},
					diagnosticsDelay = 300,
					formatterLineLength = 80,
					forwardSearch = {
						args = {},
					},
					latexFormatter = "latexindent",
					latexindent = {
						modifyLineBreaks = false,
					},
				},
			},
		})

		-- add vim user dictionary for ltex-ls
		-- local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
		-- local words = {}
		--
		-- for word in io.open(path, "r"):lines() do
		-- 	table.insert(words, word)
		-- end

		lspconfig["ltex"].setup({
			capabilities = capabilities,
			single_file_support = false,
			on_attach = on_attach,
			settings = {
				ltex = {
					disabledRules = {
						["en-US"] = { "PROFANITY" },
					},
					-- dictionary = {
					-- 	["en-US"] = words,
					-- },
				},
			},
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
