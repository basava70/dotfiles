return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gblame" }, -- loads on :Git etc
  event = "VimEnter", -- loads on first file read
  config = function()
    vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
    vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "[G]it [D]iff" })
    vim.keymap.set("n", "<leader>gB", ":Gblame<CR>", { desc = "[G]it [B]lame" })

    -- Create augroup to namespace this autocmd
    local group = vim.api.nvim_create_augroup("FugitiveCloseStatusBuffer", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "fugitive",
      callback = function()
        vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true })
      end,
    })
  end,
}
