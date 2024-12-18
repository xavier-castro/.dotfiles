return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },

  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "main",
        colorscheme = "base",
        dim_inactive_windows = true,
        styles = {
          italic = false,
          transparency = true,
        },
      })
    end,
  },

  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({
        transparent = true,
      })
    end,
  },
}
