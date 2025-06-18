return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        documentation = {
          window = { border = "rounded" },
        },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
              { "source_name" },
            },
          },
          winblend = vim.o.pumblend,
        },
      },
      keymap = {
        preset = "default",
        ["<C-y>"] = { "accept", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      cmdline = {
        keymap = {
          ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
          ["<C-j>"] = { "select_next", "fallback_to_mappings" },
        },
      },
      signature = {
        window = {
          winblend = vim.o.pumblend,
        },
      },
    },
  },
}
