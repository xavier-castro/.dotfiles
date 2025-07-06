return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup {}

    -- Create toggle function with snacks-style configuration
    local function create_toggle(name, get_state, toggle_fn, opts)
      opts = opts or {}
      local icon = opts.icon or { enabled = " ", disabled = " " }
      local color = opts.color or { enabled = "green", disabled = "yellow" }

      return function()
        toggle_fn()
        local enabled = get_state()
        local status = enabled and "enabled" or "disabled"
        local icon_str = enabled and icon.enabled or icon.disabled
        local msg = string.format("%s %s %s", icon_str, name, status)

        vim.notify(msg, vim.log.levels.INFO, { title = "Toggle" })
      end
    end
    -- Supermaven toggle with snacks-style feedback
    local toggle_supermaven = create_toggle(
      "Supermaven",
      function() return require("supermaven-nvim.api").is_running() end,
      function() require("supermaven-nvim.api").toggle() end,
      { icon = { enabled = "🤖", disabled = "🚫" } }
    )

    vim.keymap.set("n", "<leader>uM", toggle_supermaven, { desc = "Toggle Supermaven" })
  end,
}
