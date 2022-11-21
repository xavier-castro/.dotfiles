local hop = require('hop')
local directions = require('hop.hint').HintDirection
local Remap = require("xavier.keymap")

Remap.nnoremap('<leader><leader>', "<cmd>HopWord<cr>")
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
