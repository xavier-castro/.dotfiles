local status, bufferline = pcall(require, "bufferline")
if not status then
  print("ERROR bufferline")
  return
end

bufferline.setup({
  highlights = {
    buffer_selected = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
  },

  options = {
    indicator = {
      left = "▎",
      right = "▎",
    },
    tab_size = 20,
    modified_icon = "●",
    buffer_close_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    numbers = "ordinal",
    max_name_length = 15,
    max_prefix_length = 6,
    diagnostics = "nvim_lsp",
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    persist_buffer_sort = true,
    enforce_regular_tabs = true,
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and "" or ""
      return icon .. count
    end,
  },
})

local nnoremap = require("xavier.keymap").nnoremap

for i = 1, 9 do
  nnoremap("<leader>" .. i, function()
    require("bufferline").go_to_buffer(i, true)
  end)
end
nnoremap("<leader>" .. 0, function()
  require("bufferline").go_to_buffer(-1, true)
end)
