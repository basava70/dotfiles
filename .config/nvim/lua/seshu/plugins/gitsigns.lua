return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns
			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

      -- stylua: ignore start
      map("n", "]h", gs.next_hunk, "Next [H]unk")
      map("n", "[h", gs.prev_hunk, "Prev [H]unk")
      map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "[S]tage Hunk")
      map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "[R]eset Hunk")
      map("n", "<leader>gS", gs.stage_buffer, "[S]tage [B]uffer")
      map("n", "<leader>gu", gs.undo_stage_hunk, "[U]ndo Stage [H]unk")
      map("n", "<leader>gR", gs.reset_buffer, "[R]eset [B]uffer")
      map("n", "<leader>gp", gs.preview_hunk, "[P]review Hunk")
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "[B]lame Line")
      map("n", "<leader>gd", gs.diffthis, "[D]iff This")
      map("n", "<leader>gD", function() gs.diffthis("~") end, "[D]iff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
		end,
	},
}
