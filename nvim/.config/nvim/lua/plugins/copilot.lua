-- return {
--   {
--     "zbirenbaum/copilot.lua",
--     cmd = "Copilot",
--     event = "InsertEnter",
--     config = function()
--       require("copilot").setup({
--         suggestion = {
--           enabled = true,
--           auto_trigger = true,
--           hide_during_completion = true,
--           debounce = 25,
--           keymap = {
--             accept = false,
--             accept_word = false,
--             accept_line = "<M-y>",
--             next = false,
--             prev = false,
--             dismiss = "<M-e>",
--           },
--         },
--       })
--       vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#575251" })
--       vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#575251" })
--     end,
--   },
-- }

return {
  -- copilot
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          accept_word = "<M-l>",
          accept_line = "<M-S-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
