return {
  "Civitasv/cmake-tools.nvim",
  opts = {
    cmake_virtual_text_support = true,
  },
  keys = {
    {
      "<leader>msp",
      function()
        vim.cmd("CMakeSelectConfigurePreset")
      end,
      desc = "Select CMake Configure Preset",
    },
    {
      "<leader>msb",
      function()
        vim.cmd("CMakeSelectBuildPreset")
      end,
      desc = "Select CMake Build Preset",
    },
    {
      "<leader>mb",
      function()
        vim.cmd("CMakeBuild")
      end,
      desc = "CMake: Build",
    },
    {
      "<leader>mst",
      function()
        vim.cmd("CMakeSelectLaunchTarget")
      end,
      desc = "Select CMake Launch Target",
    },
    {
      "<leader>mr",
      function()
        vim.cmd("CMakeRun")
      end,
      desc = "CMake: Run",
    },
    {
      "<leader>mc",
      function()
        vim.cmd("CMakeClean")
      end,
      desc = "CMake: Clean",
    },
    {
      "<leader>mq",
      function()
        vim.cmd("CMakeCloseRunner")
      end,
      desc = "Close Runner",
    },
    {
      "<leader>mQ",
      function()
        vim.cmd("CMakeCloseExecutor")
      end,
      desc = "Close Executor",
    },
  },
}
