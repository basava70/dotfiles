-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Helper function to set keymaps with description
local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- save file without auto-formatting
map("n", "<leader>sn", "<cmd>noautocmd w <CR>", "Save without formatting")

-- quit file
map("n", "<leader>qq", "<cmd> qall <CR>", "Quit all buffers")

-- save all buffers and quit
map("n", "<leader>sqq", "<cmd> wqa <CR>", "Save and quit all buffers")

-- delete single character without copying into register
map("n", "x", '"_x')

-- Vertical scroll and center
vim.keymap.set(
	"n",
	"<C-d>",
	[[<Cmd>lua vim.cmd('normal! <C-d>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]]
)
vim.keymap.set(
	"n",
	"<C-u>",
	[[<Cmd>lua vim.cmd('normal! <C-u>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]]
)
-- map('n', '<C-d>', '<C-d>zz')
-- map('n', '<C-u>', '<C-u>zz')

-- Find and center
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Resize with arrows
map("n", "<Up>", ":resize -2<CR>")
map("n", "<Down>", ":resize +2<CR>")
map("n", "<Left>", ":vertical resize -2<CR>")
map("n", "<Right>", ":vertical resize +2<CR>")

-- Buffers
map("n", "<Tab>", ":bnext<CR>", "Next buffer")
map("n", "<S-Tab>", ":bprevious<CR>", "Previous buffer")
map("n", "<leader>x", ":bdelete!<CR>", "Delete current buffer") -- close buffer
map("n", "<leader>b", "<cmd> enew <CR>", "Create new buffer") -- new buffer

-- Window management
map("n", "<leader>J", "<C-w>v", "Split window vertically") -- split window vertically
map("n", "<leader>L", "<C-w>s", "Split window horizontally") -- split window horizontally
map("n", "<leader>se", "<C-w>=", "Make Split equal") -- make split windows equal width & height
map("n", "<leader>xs", ":close<CR>", "Close current split window") -- close current split window

-- Navigate between splits
map("n", "<C-k>", ":wincmd k<CR>")
map("n", "<C-j>", ":wincmd j<CR>")
map("n", "<C-h>", ":wincmd h<CR>")
map("n", "<C-l>", ":wincmd l<CR>")

-- Toggle line wrapping
map("n", "<leader>lw", "<cmd>set wrap!<CR>", "Toggle line wrapping")

-- Stay in indent mode
map("v", "<", "<gv", "Indent left")
map("v", ">", ">gv", "Indent right")

-- Keep last yanked when pasting
map("v", "p", '"_dP')

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
map("n", "<leader>d", vim.diagnostic.open_float, "Open floating diagnostic message")
map("n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
