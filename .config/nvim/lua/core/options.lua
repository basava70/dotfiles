-- Set <space> as the leader key
-- This key is used as the main prefix for all your custom mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in your terminal
vim.g.have_nerd_font = true

-- [[ UI Options ]]

-- Show absolute line numbers
vim.opt.number = true

-- Use relative numbers (helps with quickly jumping lines with `j`/`k`)
vim.opt.relativenumber = true

-- Always show the sign column (used by gitsigns, LSP diagnostics, etc.)
vim.opt.signcolumn = "yes"

-- Highlight the current line to make cursor position more visible
vim.opt.cursorline = true

-- Enable true color support for better themes
vim.opt.termguicolors = true

-- Set command line height (some plugins might want more space here)
vim.opt.cmdheight = 1

-- Always show the tabline (even if only one tab is open)
vim.opt.showtabline = 2

-- Don't show --INSERT--, --VISUAL-- etc., since your statusline likely handles this
vim.opt.showmode = false

-- [[ Clipboard Settings ]]

-- Sync clipboard between OS and Neovim (works with `unnamedplus`)
-- This is deferred slightly to improve startup time
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- [[ Indentation and Tab Settings ]]

-- Use auto-indenting for new lines
vim.opt.autoindent = true

-- Smarter auto-indenting (respects file types better)
vim.opt.smartindent = true

-- Wrap indented lines visually
vim.opt.breakindent = true

-- Number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 4

-- Number of spaces a tab counts for (in visual representation)
vim.opt.tabstop = 4

-- Number of spaces for a tab during editing (insertion and deletion)
vim.opt.softtabstop = 4

-- Convert actual tab characters to spaces (soft tabs)
vim.opt.expandtab = true

-- [[ Wrapping and Cursor Movement ]]

-- Enable line wrapping
vim.opt.wrap = true

-- Don't break wrapped lines in the middle of words
vim.opt.linebreak = true

-- Allow cursor to move to next/prev line with <Left>/<Right>, etc.
vim.opt.whichwrap = "bs<>[]hl"

-- Minimal number of screen lines to keep above and below cursor
vim.opt.scrolloff = 10

-- Minimal number of columns to keep left/right of cursor when not wrapping
vim.opt.sidescrolloff = 8

-- [[ Search Settings ]]

-- Case-insensitive searching unless search term has uppercase
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search matches (can toggle with `:nohlsearch`)
vim.opt.hlsearch = true

-- Preview substitution results live in a split
vim.opt.inccommand = "split"

-- [[ Backup and Undo ]]

-- Disable swap file (can be annoying, especially with modern projects)
vim.opt.swapfile = false

-- Disable backup files (redundant with version control)
vim.opt.backup = false
vim.opt.writebackup = false

-- Enable undo history across sessions
vim.opt.undofile = true

-- [[ Performance Tweaks ]]

-- Faster updates for better responsiveness (especially with LSP, git, etc.)
vim.opt.updatetime = 250

-- Shorter wait for mapped key sequences
vim.opt.timeoutlen = 300

-- [[ File Settings ]]

-- Always use UTF-8 encoding
vim.opt.fileencoding = "utf-8"

-- Show all content in markdown (no "conceal" hiding)
vim.opt.conceallevel = 0

-- [[ Completion Settings ]]

-- Show menu even if only one completion option exists, and don't auto-select
vim.opt.completeopt = "menuone,noselect"

-- [[ Miscellaneous Options ]]

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Show special characters for tabs, trailing spaces, etc.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Suppress unnecessary completion messages
vim.opt.shortmess:append("c")

-- Treat words with dashes as single words (useful for CSS, etc.)
vim.opt.iskeyword:append("-")

-- Remove legacy vim runtime path (helps keep Neovim clean)
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")

-- Prevent comment continuation when hitting `o`/`O`
vim.opt.formatoptions:remove({ "c", "r", "o" })
