return {
  "folke/snacks.nvim",
  keys = {
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
    indent = { enabled = false },
    image = {},
    scroll = { enabled = false },
    picker = {
      win = {
        input = {
          keys = {
            ["<a-s>"] = { "flash", mode = { "n", "i" } },
            ["s"] = { "flash" },
            ["<c-t>"] = {
              "trouble_open",
              mode = { "n", "i" },
            },
          },
        },
      },
      actions = {
        flash = function(picker)
          require("flash").jump({
            pattern = "^",
            label = { after = { 0, 0 } },
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          })
        end,
      },
      sources = {
        explorer = {
          layout = { layout = { position = "left" } },
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
