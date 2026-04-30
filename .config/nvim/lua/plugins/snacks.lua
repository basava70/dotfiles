return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "right",
        },
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            },
          },
        },
        layout = "dropdown",
        layouts = {
          dropdown = {
            layout = {
              backdrop = false,
              row = 4,
              width = 0.9,
              min_width = 80,
              height = 0.9,
              border = "none",
              box = "vertical",
              { win = "preview", title = "{preview}", height = 0.7, border = "rounded" },
              {
                box = "vertical",
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
            },
          },
          vscode = {
            layout = {
              row = 0.4,
            },
          },
        },
        sources = {
          files = { hidden = true },
          ignored = { true },
        },
        hidden = true, -- for hidden files
        ignored = true, -- for .gitignore files
      },
    },
    keys = {
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches({
            all = true,
            layout = "select",
          })
        end,
        desc = "Git Branches",
      },
    },
  },
}
