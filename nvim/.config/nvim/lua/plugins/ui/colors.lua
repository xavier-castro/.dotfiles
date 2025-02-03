function ColorMyPencils(color)
  color = color or "vscode"
  vim.cmd.colorscheme(color)
  -- Set transparent background
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.cmd([[
        hi ColorColumn ctermbg=234 guibg=#1c1c1c
  ]])
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
  {
    "datsfilipe/vesper.nvim",
    config = function()
      require("vesper").setup({
        transparent = false, -- Boolean: Sets the background to transparent
        italics = {
          comments = true, -- Boolean: Italicizes comments
          keywords = true, -- Boolean: Italicizes keywords
          functions = true, -- Boolean: Italicizes functions
          strings = true, -- Boolean: Italicizes strings
          variables = true, -- Boolean: Italicizes variables
        },
        overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
        palette_overrides = {},
      })
      -- ColorMyPencils()
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
      vim.g.zenbones_darken_comments = 45
      vim.cmd.colorscheme("zenbones")
      vim.cmd([[
      hi ColorColumn ctermbg=234 guibg=#1c1c1c
]])
    end,
  },
  {
    "cranberry-clockworks/coal.nvim",
    config = function()
      require("coal").setup({
        colors = {
          smoky_black = "#00FFFFFF",
        },
      })
      ColorMyPencils()
    end,
  },
  -- Vim Colors Plain
  {
    "andreypopp/vim-colors-plain",
    config = function()
      ColorMyPencils()
    end,
  },
  -- No Clown Fiesta
  {
    "aktersnurra/no-clown-fiesta.nvim",
    config = function()
      require("no-clown-fiesta").setup({
        transparent = false,
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
      ColorMyPencils()
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
    "rose-pine/neovim",
    name = "rose-pine-main",
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        styles = {
          italic = false,
        },
        ColorMyPencils(),
      })
    end,
  },

  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({
        -- transparent = true,
      })
      ColorMyPencils()
    end,
  },
  {
    "kaiuri/nvim-juliana",
    lazy = false,
    opts = { --[=[ configuration --]=]
      colors = {
        bg1 = "#444e59",
        bg2 = "#303841",
        bg3 = "#2e353e",
        blue1 = "#95b2d6",
        blue2 = "#5c99d6",
        cyan1 = "#87c7c7",
        cyan2 = "#5fb4b4",
        diff_add = "#41525a",
        diff_change = "#585249",
        diff_remove = "#4f434a",
        diff_text = "#373f48",
        fg1 = "#ffffff",
        fg2 = "#d8dee9",
        fg3 = "#a6acb9",
        fg4 = "#46525c",
        green = "#99c794",
        magenta = "#c695c6",
        orange = "#f97b58",
        red1 = "#c76b70",
        red2 = "#ec5f66",
        selection_bg = "#3f4750",
        text_fg = "#d9d9d9",
        yellow1 = "#fac761",
        yellow2 = "#f9ae58",
        yellow3 = "#ee932b",
      },
    },
    config = function()
      ColorMyPencils()
    end,
  },
}
