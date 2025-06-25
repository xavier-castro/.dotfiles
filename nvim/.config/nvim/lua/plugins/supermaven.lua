return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      disable_keymaps = true,
    })

    vim.keymap.set("i", "<C-j>", function()
      local suggestion = require("supermaven-nvim.completion_preview")

      if suggestion.has_suggestion() then
        suggestion.accept_suggestion()
      end
    end)
  end,
}
