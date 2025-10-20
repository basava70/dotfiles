return {
  {
    "folke/which-key.nvim",
    opts = function()
      local wk = require("which-key")

      wk.add({
        --  CMake group
        {
          "<leader>m",
          group = "CMake",
          icon = { icon = "", color = "azure" },
        },

        -- 󰒓 Presets / Configure
        {
          "<leader>mp",
          "<cmd>CMakeSelectConfigurePreset<CR>",
          desc = "Select Preset",
          icon = { icon = "󰒓", color = "purple" },
        },
        {
          "<leader>mg",
          "<cmd>CMakeGenerate<CR>",
          desc = "Generate Build Files",
          icon = { icon = "", color = "azure" },
        },

        --  Build /  Clean
        {
          "<leader>mb",
          "<cmd>CMakeBuild<CR>",
          desc = "Build Project",
          icon = { icon = "", color = "green" },
        },
        {
          "<leader>mc",
          "<cmd>CMakeClean<CR>",
          desc = "Clean Build",
          icon = { icon = "", color = "red" },
        },

        -- 󰜎 Run / 󰜺 Close
        {
          "<leader>mr",
          "<cmd>CMakeRun<CR>",
          desc = "Run Target",
          icon = { icon = "󰜎", color = "cyan" },
        },
        {
          "<leader>mx",
          "<cmd>CMakeCloseRunner<CR>",
          desc = "Close Runner",
          icon = { icon = "󰜺", color = "orange" },
        },

        -- 󰙨 Tests (optional)
        {
          "<leader>mt",
          "<cmd>CMakeRunTests<CR>",
          desc = "Run Tests",
          icon = { icon = "󰙨", color = "yellow" },
        },

        --  Build + Run combo
        {
          "<leader>mm",
          function()
            vim.cmd("CMakeBuild")
            vim.cmd("CMakeRun")
          end,
          desc = "Build & Run",
          icon = { icon = "", color = "green" },
        },
      })
    end,
  },
}
