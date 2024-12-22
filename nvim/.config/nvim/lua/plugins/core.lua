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
