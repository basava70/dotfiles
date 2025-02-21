return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true, -- for hidden files
        ignored = false, -- dont show .gitignore files
        sources = {
          files = {
            hidden = true,
          },
        },
      },
    },
  },
}
