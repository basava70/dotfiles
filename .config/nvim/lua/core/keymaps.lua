-- [[ Leader Key ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable space from being used directly (prevent accidental leader triggers)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Helper function to simplify keymap creation with descriptions
local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- [[ General Keymaps ]]

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")

-- Save file without triggering autoformat
map("n", "<leader>sN", "<cmd>noautocmd w<CR>", "Save without formatting")

-- Save all buffers and quit
map("n", "<leader>xs", "<cmd>wqa<CR>", "e[X]it and [S]ave all buffers")

-- Delete a single character without copying into register
map("n", "x", '"_x', "Delete without copying")
-- Substitue a single character without copying into register
map("n", "s", '"_s', "Delete without copying")

-- [[ Centering Movements ]]

-- Center screen after scrolling
map("n", "<C-d>", "<C-d>zz", "Scroll down and center")
map("n", "<C-u>", "<C-u>zz", "Scroll up and center")

-- Center screen after search navigation
map("n", "n", "nzzzv", "Next search result and center")
map("n", "N", "Nzzzv", "Previous search result and center")

--[[ Buffer Management]]
map("n", "<leader>xL", "<cmd> BufferLineCloseLeft <CR>", "Close all buffers to left") -- close buffers to the left
map("n", "<leader>xR", "<cmd> BufferLineCloseRight <CR>", "Close all buffers to right") -- close buffers to the right
map("n", "<leader>xA", "<cmd> BufferLineCloseOthers <CR>", "Close all other buffers") -- close all buffers expect current one
map("n", "<A-.>", "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer")
map("n", "<A-,>", "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer")
map("n", "<A-s-.>", "<cmd> BufferLineMoveNext <CR>", "  move next buffer")
map("n", "<A-s-,>", "<cmd> BufferLineMovePrev <CR>", "  move prev buffer")
map("n", "<A-f>", "<cmd> BufferLinePick <CR>")
map("n", "<leader>xx", "<cmd> bp|sp|bn|bd! <CR>", "Close the current buffer") --"	close buffer"
for i = 1, 9 do
	vim.keymap.set("n", "<A-" .. i .. ">", function() -- choose <A-i> to choose that buffer
		require("bufferline").go_to_buffer(i)
	end)
end

-- [[ Window Management ]]

-- Resize windows
map("n", "<Up>", "<cmd>resize -2<CR>", "Resize split up")
map("n", "<Down>", "<cmd>resize +2<CR>", "Resize split down")
map("n", "<Left>", "<cmd>vertical resize -2<CR>", "Resize split left")
map("n", "<Right>", "<cmd>vertical resize +2<CR>", "Resize split right")

-- Equalize split sizes
map("n", "<leader>se", "<C-w>=", "Equalize split sizes")

-- Navigate splits
map("n", "<C-h>", "<C-w>h", "Move to left split")
map("n", "<C-l>", "<C-w>l", "Move to right split")
map("n", "<C-j>", "<C-w>j", "Move to lower split")
map("n", "<C-k>", "<C-w>k", "Move to upper split")

-- [[ Indent Management ]]

-- Stay in indent mode
map("v", "<", "<gv", "Indent left and stay in visual mode")
map("v", ">", ">gv", "Indent right and stay in visual mode")

-- [[ Paste Handling ]]

-- Keep last yanked when pasting over selected text
map("v", "p", '"_dP', "Paste without overwriting register")

-- [[ Diagnostic Keymaps ]]

map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
map("n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostic list")

-- [[ Wrapping Toggle ]]

map("n", "<leader>lw", "<cmd>set wrap!<CR>", "Toggle line wrapping")

-- [[ Terminal Escape ]]

map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")

-- [[ Highlight Yanking ]]

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
