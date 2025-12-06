-- lua/plugins/rose-pine.lua
return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   opts = { style = "night" },
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  { "EdenEast/nightfox.nvim" }, -- lazy
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
