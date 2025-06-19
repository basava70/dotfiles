-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Disable space from being used directly (prevent accidental leader triggers)
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
