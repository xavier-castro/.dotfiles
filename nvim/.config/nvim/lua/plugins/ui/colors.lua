function ColorMyPencils(color)
  color = color or "juliana"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "juliana",
    },
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
        transparent = true,
      })
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
    config = true,
  },
}
