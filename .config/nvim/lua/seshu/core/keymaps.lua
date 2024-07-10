-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness(" ")

-- General Keymaps
-- remove search highlight
keymap.set("n", "<ESC>", "<cmd> nohlsearch <CR>", { desc = "remove search hightlight" })

-- use jj to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- copying from vim to system clipboard
keymap.set("v", "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })

-- Primegean way of adding lines with J
keymap.set("n", "J", "mzJ`z")

-- in visual mode move the block up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Close all buffers and exit Neovim
keymap.set("n", "<leader>q", "<cmd> qall <CR> ", { desc = "Close all buffers without saving" })
-- save all buffers and exit Neovim
keymap.set("n", "<leader>w", "<cmd> wqall <CR> ", { desc = "Close all buffers after saving" })

-- bufferline
keymap.set("n", "<leader>bcl", "<cmd> BufferLineCloseLeft <CR>", { desc = "everything to [L]eft" }) -- close buffers to the left
keymap.set("n", "<leader>bcr", "<cmd> BufferLineCloseRight <CR>", { desc = "everything to [R]ight" }) -- close buffers to the right
keymap.set("n", "<leader>bca", "<cmd> BufferLineCloseOthers <CR>", { desc = "[A]ll other buffers" }) -- close all buffers expect current one
keymap.set("n", "<A-.>", "<cmd> BufferLineCycleNext <CR>") --"  cycle next buffer"
keymap.set("n", "<A-,>", "<cmd> BufferLineCyclePrev <CR>") --"  cycle prev buffer"
keymap.set("n", "<A-s-.>", "<cmd> BufferLineMoveNext <CR>") --"  move next buffer"
keymap.set("n", "<A-s-,>", "<cmd> BufferLineMovePrev <CR>") --"  move prev buffer"
keymap.set("n", "<A-f>", "<cmd> BufferLinePick <CR>")
keymap.set("n", "<leader>bcc", "<cmd> bp|sp|bn|bd! <CR>", { desc = "[C]urrent buffer" }) --"	close buffer"
for i = 1, 9 do
	keymap.set("n", "<A-" .. i .. ">", function() -- choose <A-i> to choose that buffer
		require("bufferline").go_to_buffer(i)
	end)
end
keymap.set("n", "<leader>br", "<cmd> bufdo e <CR>", { desc = "[R]eload all" }) -- Reload all Buffers

-- formatting
keymap.set("n", "<leader>sd", "<cmd> FormatDisable <CR>", { desc = "[D]isable Format" })
keymap.set("n", "<leader>se", "<cmd> FormatEnable <CR>", { desc = "[E]nable Format" })

-- markdown preview
keymap.set("n", "<leader>m", "<cmd> MarkdownPreview <CR>", { desc = "[M]arkdown preview" })

-- lazy
keymap.set("n", "<leader>l", "<cmd> Lazy<CR>", { desc = "[L]azy UI" })
