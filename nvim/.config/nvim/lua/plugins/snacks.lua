return {
  "folke/snacks.nvim",
  keys = {
    -- Top Pickers & Explorer
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<C-p>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
  },
  opts = {
    bigfile = { enabled = true },
    image = {},
    indent = { enabled = false },
    line_number = { enabled = false },
    scroll = { enabled = false },
    explorer = { enabled = true },
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
