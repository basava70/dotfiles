return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gblame" }, -- loads on :Git etc
  event = "VimEnter", -- loads on first file read
  config = function()
    vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
    vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "[G]it [D]iff" })
    vim.keymap.set("n", "<leader>gB", ":Gblame<CR>", { desc = "[G]it [B]lame" })

    -- Push branch to origin (works even if its a new branch)
    vim.keymap.set("n", "<leader>gp", function()
      local handle = io.popen("git rev-parse --abbrev-ref HEAD")
      if not handle then
        vim.notify("Failed to get current Git branch", vim.log.levels.ERROR, { title = "Git" })
        return
      end
      local branch = handle:read("*a")
      handle:close()
      if not branch or branch == "" then
        vim.notify("Git branch name is empty", vim.log.levels.ERROR, { title = "Git" })
        return
      end
      -- Clean up whitespace/newlines
      branch = branch:gsub("%s+", "")
      vim.cmd("Git push --set-upstream origin " .. branch)
    end, { desc = "[G]it [P]ush (auto upstream)" })

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
