-- lua/plugins/colorscheme.lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_italics = true,

        highlight_groups = {
          ["Comment"] = { italic = true },
          ["@comment"] = { italic = true },
          ["@comment.documentation"] = { italic = true },
          ["@lsp.type.comment"] = { italic = true },
          ["@lsp.type.comment.cpp"] = { italic = true },
        },

        palette = {
          main = {
            rose = "#eaaaA8",
          },
        },
      })
    end,
  },
  { "EdenEast/nightfox.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
