return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "no-clown-fiesta",
    },
  },
  -- Vim Colors Plain
  {
    "andreypopp/vim-colors-plain",
    config = function()
      -- vim.cmd.colorscheme("plain")
    end,
  },
  -- No Clown Fiesta
  {
    "aktersnurra/no-clown-fiesta.nvim",
    config = function()
      require("no-clown-fiesta").setup({
        transparent = true,
        styles = {
          -- You can set any of the style values specified for `:h nvim_set_hl`
          comments = {},
          keywords = {},
          functions = {},
          variables = {},
          type = { bold = false },
          lsp = { underline = false },
        },
      })
      vim.cmd.colorscheme("no-clown-fiesta")
      vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#212121", bg = "#212121" })
    end,
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
    "rebelot/kanagawa.nvim",
    config = function()
      -- Default options:
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {
          -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = {
          -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })
    end,
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
