return {
  "Civitasv/cmake-tools.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  ft = { "c", "cpp", "cuda", "objc", "objcpp", "cmake" },
  opts = {
    cmake_runner = {
      name = "toggleterm",
      opts = {},
    },
  },
}
