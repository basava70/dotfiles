return {
  "neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = false, -- hide filtered items on open
        hide_gitignored = true,
        hide_dotfiles = false,
        hide_by_name = {
          ".github",
          ".gitignore",
          "package-lock.json",
          ".changeset",
          ".prettierrc.json",
          ".DS_store",
          "thumbs.db",
        },
        never_show = { ".git" },
      },
    },
  },
}
