-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness(" ")

-- General Keymaps
-- remove search highlight
keymap.set("n", "<leader>n", "<cmd> nohlsearch <CR>", { desc = "remove search hightlight" })

-- use jj to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- copying from vim to system clipboard
keymap.set("v", "<leader>y", '"+y', { desc = "Copy the selection to system clipboard" })

-- Primegean way of adding lines with J
keymap.set("n", "J", "mzJ`z")

-- in visual mode move the block up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Reload buffers (usage : after changing branches in git)
keymap.set("n", "<leader>E", "<cmd> bufdo e <CR>", { desc = "reload all buffers" })

-- Close all buffers and exit Neovim
keymap.set("n", "<leader>q", "<cmd> qall <CR> ", { desc = "close all buffers" })
-- save all buffers and exit Neovim
keymap.set("n", "<leader>w", "<cmd> wqall <CR> ", { desc = "close all buffers" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- bufferline
keymap.set("n", "<leader>bxl", "<cmd> BufferLineCloseLeft <CR>", { desc = "Close all buffers to left" }) -- close buffers to the left
keymap.set("n", "<leader>bxr", "<cmd> BufferLineCloseRight <CR>", { desc = "Close all buffers to right" }) -- close buffers to the right
keymap.set("n", "<leader>bxx", "<cmd> BufferLineCloseOthers <CR>", { desc = "Close all other buffers" }) -- close all buffers expect current one
keymap.set("n", "<A-.>", "<cmd> BufferLineCycleNext <CR>") --"  cycle next buffer"
keymap.set("n", "<A-,>", "<cmd> BufferLineCyclePrev <CR>") --"  cycle prev buffer"
keymap.set("n", "<A-s-.>", "<cmd> BufferLineMoveNext <CR>") --"  move next buffer"
keymap.set("n", "<A-s-,>", "<cmd> BufferLineMovePrev <CR>") --"  move prev buffer"
keymap.set("n", "<A-f>", "<cmd> BufferLinePick <CR>")
keymap.set("n", "<leader>bbx", "<cmd> bp|sp|bn|bd! <CR>", { desc = "Close the current buffer" }) --"	close buffer"
for i = 1, 9 do
	keymap.set("n", "<A-" .. i .. ">", function() -- choose <A-i> to choose that buffer
		require("bufferline").go_to_buffer(i)
	end)
end

-- trouble
keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end, { desc = "toggle trouble list" })
keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end, { desc = "toggle workspace_diagnostics" })
keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end, { desc = "toggle document_diagnostics" })
keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end, { desc = "toggle quickfix" })
keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end, { desc = "toggle loclist" })
keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end, { desc = "toggle lsp_references" })

-- formatting
keymap.set("n", "<leader>fd", "<cmd> FormatDisable <CR>", { desc = "Disable format" }) -- disable formatting.
keymap.set("n", "<leader>fe", "<cmd> FormatEnable <CR>", { desc = "Enable format" }) -- enable formatting.

-- markdown preview
keymap.set("n", "<leader>m", "<cmd> MarkdownPreview <CR>", { desc = "Markdown Preview" })
