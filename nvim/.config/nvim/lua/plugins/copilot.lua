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
--           hide_during_completion = false,
--           debounce = 25,
--           keymap = {
--             accept = "<Tab>",
--             accept_word = false,
--             accept_line = false,
--             next = "<C-]",
--             prev = "<C-[>",
--             dismiss = "<C-e>",
--           },
--         },
--       })
--     end,
--   },
-- }

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          accept_word = "<C-L>",
          accept_line = "<C-CR>",
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<ESC>",
        },
      },
      filetypes = {
        markdown = true,
        yaml = true,
        help = true,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
      },
    })
  end,
}
