return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua-language-server",
        "stylua",
        "pyright",
        "black",
        "ruff",
        "isort",
        "prettier",
        "latexindent",
        "bibtex-tidy",
        "shfmt",
        "neocmakelsp",
        "cmakelang",
        "neocmakelsp",
        "luacheck",
        "shellcheck",
        "shfmt",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = true,
        -- virtual_lines = { current_line = true },
        -- underline = true,
        update_in_insert = false,
        float = { border = "rounded" },
      },
      inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        -- Ensure mason installs the server
      },
      setup = {},
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function()
  --     local keys = require("lazyvim.plugins.lsp.keymaps").get()
  --     vim.list_extend(keys, {
  --       {
  --         "gd",
  --         function()
  --           -- DO NOT RESUSE WINDOW
  --           require("telescope.builtin").lsp_definitions({ reuse_win = false })
  --         end,
  --         desc = "Goto Definition",
  --         has = "definition",
  --       },
  --     })
  --   end,
  -- },
}
