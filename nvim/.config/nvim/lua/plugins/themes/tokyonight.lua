return {
  lazy = false,
  priority = 1000,
  'folke/tokyonight.nvim',
  opts = {
    style = 'storm',
    transparent = false,
    styles = {
      sidebars = 'transparent',
    },
    config = function()
      vim.cmd [[colorscheme tokyonight-storm]]
    end,
  },
}
