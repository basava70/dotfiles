-- lua/plugins/rose-pine.lua
return {
  -- {
  --   "catppuccin/nvim",
  --   lazy = true,
  --   name = "catppuccin",
  --   opts = {
  --     lsp_styles = {
  --       underlines = {
  --         errors = { "undercurl" },
  --         hints = { "undercurl" },
  --         warnings = { "undercurl" },
  --         information = { "undercurl" },
  --       },
  --     },
  --     integrations = {
  --       aerial = true,
  --       alpha = true,
  --       cmp = true,
  --       dashboard = true,
  --       flash = true,
  --       fzf = true,
  --       grug_far = true,
  --       gitsigns = true,
  --       headlines = true,
  --       illuminate = true,
  --       indent_blankline = { enabled = true },
  --       leap = true,
  --       lsp_trouble = true,
  --       mason = true,
  --       mini = true,
  --       navic = { enabled = true, custom_bg = "lualine" },
  --       neotest = true,
  --       neotree = true,
  --       noice = true,
  --       notify = true,
  --       snacks = true,
  --       telescope = true,
  --       treesitter_context = true,
  --       which_key = true,
  --     },
  --   },
  --   specs = {
  --     {
  --       "akinsho/bufferline.nvim",
  --       optional = true,
  --       opts = function(_, opts)
  --         if (vim.g.colors_name or ""):find("catppuccin") then
  --           opts.highlights = require("catppuccin.special.bufferline").get_theme()
  --         end
  --       end,
  --     },
  --   },
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   opts = { style = "night" },
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      -- require("rose-pine").setup({
      --   disable_italics = true,
      --   highlight_groups = {
      --     ["@keyword.conditional"] = { italic = true }, -- if, else
      --     ["@keyword.repeat"] = { italic = true }, -- for, while
      --     ["@keyword.return"] = { italic = true }, -- return
      --     ["@type.builtin"] = { italic = true }, -- int, float, etc.
      --     ["@keyword.operator"] = { italic = true }, -- new, delete, etc.
      --     ["@preproc"] = { italic = true }, -- #define, #include, etc.
      --     ["@comment"] = { italic = true },
      --     ["@comment.documentation"] = { italic = true },
      --     -- ["@comment.tagged"] = { fg = "#eb6f92" },
      --     ["@string"] = { italic = true },
      --   },
      --   palette = {
      --     main = {
      --       rose = "#eaaaA8",
      --       -- rose = "#ea9a97",
      --     },
      --   },
      --   styles = {
      --     transparency = true,
      --   },
      -- })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
