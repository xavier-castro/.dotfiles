return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({
        transparent = false,
      })
      ColorMyPencils()
    end,
  },
  -- Lua

  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("poimandres").setup({
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
        bold_vert_split = false, -- use bold vertical separators
        dim_nc_background = false, -- dim 'non-current' window backgrounds
        disable_background = true, -- disable background
        disable_float_background = false, -- disable background for floats
        disable_italics = false, -- disable italics
        ColorMyPencils(),
      })
    end,

    -- optionally set the colorscheme within lazy config
    init = function()
      vim.cmd("colorscheme poimandres")
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = false,
      }
    end,
  },
}
