return {
  "Civitasv/cmake-tools.nvim",
  opts = {
    filetypes = { "c", "cpp", "cuda", "objc", "objcpp", "cmake" },
    cmake_executor = {
      default_opts = {
        quickfix = {
          auto_close_when_success = false,
        },
      },
    },
  },
}
