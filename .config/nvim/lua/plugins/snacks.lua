return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            },
          },
        },
        actions = {
          custom = {
            desc = "Git merge selected branch into current",
            name = "custom",
            action = function(self, item)
              self:close()
              local line = item.text
              local branch = line:match("^%*?%s*([%w%-%._/]+)")
              local current = vim.b.gitsigns_head
              vim.cmd("Git merge --no-ff " .. branch)
              vim.notify("Merged branch " .. branch .. " into " .. current, vim.log.levels.INFO, {
                title = "Git",
              })
            end,
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
        "<leader>gD",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (Hunks)",
      },
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches({
            all = true,
            layout = "select",
            win = { input = { keys = { ["<C-o>"] = "custom", mode = { "i", "n" } } } },
          })
        end,
        desc = "Git Branches",
      },
      -- {
      --   "<leader>gS",
      --   function()
      --     Snacks.picker.git_status()
      --   end,
      --   desc = "Git Status",
      -- },
    },
  },
}
