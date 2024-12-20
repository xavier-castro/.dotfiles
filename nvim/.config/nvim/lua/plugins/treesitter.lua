-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Treesitter configuration for better syntax highlighting
return {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        local configs = require("nvim-treesitter.configs")
  
        configs.setup({
          ensure_installed = {
            "lua",
            "vim",
            "vimdoc",
            "javascript",
            "typescript",
            "python",
            "c",
            "cpp",
            "rust",
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    },
  }
  