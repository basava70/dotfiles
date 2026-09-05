return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Godot's LSP lives inside the editor, so tell LazyVim not to install it via Mason
        gdscript = { mason = false },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "gdscript", "godot_resource", "gdshader" } },
  },
}
