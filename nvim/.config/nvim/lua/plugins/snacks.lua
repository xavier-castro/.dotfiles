return {
  "folke/snacks.nvim",
  opts = {
    bigfile = { enabled = true },
    image = {},
    indent = { enabled = false },
    line_number = { enabled = false },
    scroll = { enabled = false },
    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
          follow_file = true,
          tree = true,
          focus = "list",
          jump = { close = false },
          auto_close = false,
          win = {
            list = {
              keys = {
                ["."] = "explorer_focus",
              },
            },
          },
        },
      },
    },
    dashboard = {
      preset = {
        header = [[
        ██╗  ██╗██╗   ██╗██╗   ██╗██████╗
        ╚██╗██╔╝██║   ██║██║   ██║██╔══██╗
         ╚███╔╝ ██║   ██║██║   ██║██████╔╝
         ██╔██╗ ╚██╗ ██╔╝╚██╗ ██╔╝██╔══██╗
        ██╔╝ ██╗ ╚████╔╝  ╚████╔╝ ██║  ██║
        ╚═╝  ╚═╝  ╚═══╝    ╚═══╝  ╚═╝  ╚═╝
                ]],
      },
    },
  },
}
