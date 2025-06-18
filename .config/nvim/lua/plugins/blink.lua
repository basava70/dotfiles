return {
  {
    "sagen/blink.cmp",
    opts = {
      completion = {
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
        },
        documentation = {
          window = { border = "rounded" },
        },
      },
      keymap = {
        preset = "default",
        ["<C-y>"] = { "accept", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      },
      cmdline = {
        keymap = {
          ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
          ["<C-j>"] = { "select_next", "fallback_to_mappings" },
        },
      },
    },
  },
}
