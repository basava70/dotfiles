return {
  -- tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- "lua-language-server",
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
        "luacheck",
        "shellcheck",
        "shfmt",
      })
    end,
  },
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false,
          cmd = { "/usr/bin/lua-language-server" },
        },
      },
    },
  },
}
