return {
  "nvzone/floaterm",
  dependencies = "nvzone/volt",
  opts = {
    {
      border = true,
      size = { h = 80, w = 90 },

      -- to use, make this func(buf)
      mappings = {
        sidebar = nil,
        term = function(buf)
          vim.keymap.set({ "n", "t" }, "<M-p>", function()
            require("floaterm.api").cycle_term_bufs("prev")
          end, { buffer = buf })
        end,
      },

      -- Default sets of terminals you'd like to open
      terminals = {
        { name = "Terminal", cmd = "fastfetch" },
        { name = "Lazygit", cmd = "lazygit" },
        -- More terminals
      },
    },
  },
  cmd = "FloatermToggle",
}
