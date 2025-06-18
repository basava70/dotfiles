return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = 0.5,
            -- col = "50%",
          },
        },
      },
      lsp = {
        progress = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        -- bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
 ███╗   ██╗ █████╗ ███╗   ██╗███╗   ██╗ █████╗ ██╗   ██╗██╗
 ████╗  ██║██╔══██╗████╗  ██║████╗  ██║██╔══██╗╚██╗ ██╔╝██║
 ██╔██╗ ██║███████║██╔██╗ ██║██╔██╗ ██║███████║ ╚████╔╝ ██║
 ██║╚██╗██║██╔══██║██║╚██╗██║██║╚██╗██║██╔══██║  ╚██╔╝  ██║
 ██║ ╚████║██║  ██║██║ ╚████║██║ ╚████║██║  ██║   ██║   ██║
 ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝   ╚═╝
          ]],
        },
      },
    },
  },
}
