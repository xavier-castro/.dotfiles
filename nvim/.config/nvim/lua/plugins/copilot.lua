return {
  "zbirenbaum/copilot.lua",
  config = function()
    local copilot = require("copilot")
    copilot.setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<M-a>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    })
  end,
}
