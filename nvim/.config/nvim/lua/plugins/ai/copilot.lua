return {
  'zbirenbaum/copilot.lua',
  config = function()
    local copilot = require 'copilot'
    copilot.setup {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept = '<M-a>',
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    }
  end,
}
