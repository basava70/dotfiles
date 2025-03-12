return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Mason for formatters/linters only (optional, no LSP servers via Mason)
		{ "williamboman/mason.nvim", config = true },
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		-- { "j-hui/fidget.nvim", opts = {} },
		-- Using mini.notify

		-- Allows extra capabilities provided by nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Set up capabilities for nvim-cmp to work with LSP
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Keymap helper (keep this as you had)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>gD", require("telescope.builtin").lsp_type_definitions, "[G]oto Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				if client and client.supports_method("textDocument/documentHighlight") then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client.supports_method("textDocument/inlayHint") then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Directly configure LSP servers (no Mason needed here)
		local servers = {
			clangd = {
				cmd = {
					"clangd",
					"--background-index", -- Background indexing of the whole project
					"--clang-tidy", -- Enable clang-tidy integration
					"--completion-style=detailed", -- Better autocompletion experience
					"--cross-file-rename", -- Rename across files
					"--header-insertion=never", -- Avoid automatic header insertion
					"--fallback-style=llvm", -- Consistent fallback formatting (in case no .clang-format exists)
				},
				capabilities = vim.tbl_deep_extend("force", {}, capabilities, {
					offsetEncoding = { "utf-8" }, -- Important for avoiding clangd offset issues
				}),
				init_options = {
					clangdFileStatus = true, -- Show file processing status
				},
			},

			pyright = {},

			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						diagnostics = {
							globals = { "vim" },
						},
						format = {
							enable = false,
						},
					},
				},
			},
		}

		-- Attach capabilities & setup each server
		for server, config in pairs(servers) do
			config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
			if server == "clangd" then
				config.on_attach = function(client, bufnr)
					-- Disable document formatting to avoid conflicts
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
			end
			require("lspconfig")[server].setup(config)
		end

		-- Mason for formatters (optional)
		require("mason").setup()

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Add formatters you want Mason to manage (optional)
				-- These are non-Pacman tools, e.g., prettier, bibtex-tidy, etc.
				-- "stylua",
				-- "black",
				-- "isort",
				-- "prettier",
				-- "latexindent",
				-- "bibtex-tidy",
				-- "cmake-format",
			},
		})
		-- 🔹 Customize Hover Window with Rounded Borders
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	end,
}
