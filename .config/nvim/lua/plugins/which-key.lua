return {
  "folke/which-key.nvim",
  optional = true,
  opts = function(_, opts)
    local wk = require("which-key")

    wk.add({
      -- MAIN GROUP ----------------------------------------------
      {
        "<leader>m",
        group = "CMake",
        icon = { icon = "", color = "blue" },
      },

      -- SELECT SUBGROUP -------------------------------------------
      {
        "<leader>ms",
        group = "Select",
        icon = { icon = "󰒓", color = "purple" },
      },

      -- Select: Configure Preset
      {
        "<leader>msp",
        "<cmd>CMakeSelectConfigurePreset<cr>",
        desc = "Configure Preset",
        icon = { icon = "", color = "purple" },
      },

      -- Select: Build Preset
      {
        "<leader>msb",
        "<cmd>CMakeSelectBuildPreset<cr>",
        desc = "Build Preset",
        icon = { icon = "󰙨", color = "purple" },
      },

      -- Select: Launch Target
      {
        "<leader>mst",
        "<cmd>CMakeSelectLaunchTarget<cr>",
        desc = "Launch Target",
        icon = { icon = "󰁨", color = "cyan" },
      },

      -- BUILD / RUN / DEBUG / CLEAN ------------------------------
      {
        "<leader>mb",
        "<cmd>CMakeBuild<cr>",
        desc = "Build Preset",
        icon = { icon = "󰜫", color = "green" },
      },

      {
        "<leader>mr",
        "<cmd>CMakeRun<cr>",
        desc = "Run Target",
        icon = { icon = "", color = "cyan" },
      },

      {
        "<leader>md",
        "<cmd>CMakeDebug<cr>",
        desc = "Debug Target",
        icon = { icon = "", color = "orange" },
      },

      {
        "<leader>mc",
        "<cmd>CMakeClean<cr>",
        desc = "Clean Build",
        icon = { icon = "", color = "red" },
      },

      -- CLOSE RUNNER / EXECUTOR -----------------------------------
      {
        "<leader>mq",
        "<cmd>CMakeCloseRunner<cr>",
        desc = "Close Runner",
        icon = { icon = "󰜺", color = "yellow" },
      },

      {
        "<leader>mQ",
        "<cmd>CMakeCloseExecutor<cr>",
        desc = "Close Executor",
        icon = { icon = "󰛌", color = "yellow" },
      },
    })
  end,
}
