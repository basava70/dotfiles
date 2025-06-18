return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = { "*" }, -- enable for all files
    user_default_options = {
      names = false, -- "blue" instead of just #0000ff
      css = true, -- enable parsing of CSS functions: rgb(), hsl()
      rgb_fn = true, -- enable parsing rgb(...) functions
      hsl_fn = true, -- enable parsing hsl(...) functions
      tailwind = true, -- enable tailwind colors
      mode = "foreground", -- "background" or "foreground"
    },
  },
}
