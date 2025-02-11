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

    -- Set the ghost text color to a subtle gray
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#777777" })
  end,
}
