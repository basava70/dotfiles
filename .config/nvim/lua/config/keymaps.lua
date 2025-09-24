-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Disable space from being used directly (prevent accidental leader triggers)
vim.keymap.set("n", "<leader>gl", function()
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.85)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
    title = "Git Log",
    title_pos = "center",
  })
  -- Get how many lines the log will produce
  local log_lines = vim.fn.systemlist(
    [[git log --graph --all --color=always --pretty=format:'%C(auto)%h%Creset %C(yellow)%d%Creset %s %Cgreen(%ar)%Creset %C(bold blue)%an%Creset']]
  )
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Git log failed." })
    return
  end
  local should_insert = #log_lines >= height - 4
  vim.api.nvim_buf_call(buf, function()
    vim.fn.termopen({
      "sh",
      "-c",
      [[git log --graph --all --color=always --pretty=format:'%C(auto)%h%Creset %C(yellow)%d%Creset %s %Cgreen(%ar)%Creset %C(bold blue)%an%Creset'; sleep 1000d]],
    })
  end)
  if should_insert then
    vim.cmd("startinsert")
  end
  -- Add this after termopen block
  vim.keymap.set({ "n", "t" }, "q", "<C-\\><C-n>:close<CR>", { buffer = buf, silent = true })
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:close<CR>", { buffer = buf, silent = true })
end, { desc = "[G]it [L]og (smart terminal)" })
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Helper function to simplify keymap creation with descriptions
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Save file without triggering autoformat
map("n", "<leader>sN", "<cmd>noautocmd w<CR>", "Save without formatting")

-- Copy full file into clipboard
map("n", "<leader>G", function()
  vim.cmd("normal! ggVGy")
end, "Copy entire file")

for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", function() -- choose <A-i> to choose that buffer
    require("bufferline").go_to_buffer(i)
  end)
end
