return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_general_viewer = "zathura"

    -- quickfix: open only when there are real errors
    vim.g.vimtex_quickfix_open_on_warning = 0

    -- 0 = never open automatically
    -- 1 = open and jump to first entry
    -- 2 = open, keep cursor in the editor  (default)
    vim.g.vimtex_quickfix_mode = 2

    -- drop noise from the list entirely (Vim regex, matched against the message)
    vim.g.vimtex_quickfix_ignore_filters = {
      "Underfull \\\\hbox",
      "Overfull \\\\hbox",
      "Underfull \\\\vbox",
      "Overfull \\\\vbox",
      "Font Warning",
      "Package caption Warning",
      "Package hyperref Warning",
      "float specifier changed",
      "Marginpar on page",
    }
  end,
  keys = {
    { "<leader>vv", "<cmd>VimtexView<cr>", desc = "Vimtex View", ft = "tex" },
    { "<leader>vc", "<cmd>VimtexCompile<cr>", desc = "Vimtex Compile", ft = "tex" },
  },
}
