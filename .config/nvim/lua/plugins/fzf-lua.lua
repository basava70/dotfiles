return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- cmd = "FzfLua",
  -- event = "VeryLazy",
  opts = {
    files = {
      git_icons = true,
      hidden = true,
      follow = true,
      -- rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
      -- fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
    },
    grep = {
      hidden = true,
      follow = true,
      -- actions = {
      --   ['ctrl-q'] = {
      --     fn = actions.file_edit_or_qf, prefix = 'select-all+'
      --   },
      -- },
    },
  },
}
