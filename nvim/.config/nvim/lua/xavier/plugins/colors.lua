return {
  {
    'vague2k/vague.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('vague').setup {
        transparent = true,
      }
    end,
  }, -- Using Lazy
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
    config = function() end,
  },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function() end,
  },
  {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    config = function() end,
  },
  {
    'erikbackman/brightburn.vim',
    lazy = false,
    priority = 1000,
    config = function() end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    opts = {},
    config = function() end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    config = function() end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function() end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    opts = {},
    config = function() end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    config = function()
      require('gruvbox').setup {
        terminal_colors = true,
        undercurl = true,
        underline = false,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = '', -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup {
        style = 'storm',
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = {
            italic = false,
          },
          keywords = {
            italic = false,
          },
          sidebars = 'dark',
          floats = 'dark',
        },
      }
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        disable_background = true,
        styles = {
          italic = false,
        },
      }
    end,
  },
}
