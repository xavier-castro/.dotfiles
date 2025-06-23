return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup {}

      -- Create a toggle function with visual feedback
      local function toggle_supermaven()
        local api = require "supermaven-nvim.api"
        api.toggle()

        -- Provide visual feedback
        if api.is_running() then
          vim.notify("Supermaven enabled", vim.log.levels.INFO)
        else
          vim.notify("Supermaven disabled", vim.log.levels.INFO)
        end
      end

      -- Set up keybinding for toggle
      vim.keymap.set("n", "<leader>tsm", toggle_supermaven, { desc = "Toggle Supermaven" })
    end,
  },
}

