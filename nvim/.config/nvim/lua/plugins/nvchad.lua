-- [[ NvChad Core Import ]]
-- This imports NvChad as a plugin, giving us access to all NvChad features
-- while maintaining our hybrid configuration structure

return {
  -- Import NvChad's base theme system
  {
    "NvChad/base46",
    lazy = false,
    priority = 1000,
    config = function()
      -- Set the cache directory for base46
      vim.g.base46_cache = vim.fn.stdpath("cache") .. "/base46/"
      
      -- Create cache directory if it doesn't exist
      vim.fn.mkdir(vim.g.base46_cache, "p")
      
      -- Load all highlights with default theme
      require("base46").load_all_highlights()
    end,
  },

  -- Import NvChad's UI components (statusline, tabufline, etc.)
  {
    "NvChad/ui",
    lazy = false,
    priority = 999,
    dependencies = { "NvChad/base46" },
    config = function()
      -- Just load the nvchad module
      require("nvchad")
    end,
  },

  -- Essential NvChad utilities
  "nvzone/volt",
  "nvzone/menu",
  { "nvzone/minty", cmd = { "Huefy", "Shades" } },
}