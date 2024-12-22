function ColorMyPencils(color)
  color = color or "rose-pine-moon"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
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
      -- vim.cmd.colorscheme("no-clown-fiesta")
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
        disable_background = true,
        styles = {
          italic = false,
        },
      })

      ColorMyPencils()
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
