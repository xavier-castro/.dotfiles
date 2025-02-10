return {
  "zbirenbaum/copilot.lua",
  config = function()
    local copilot = require("copilot")
    copilot.setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-a>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    })
  end,
}
