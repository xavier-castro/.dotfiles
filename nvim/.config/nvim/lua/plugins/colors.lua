function ColorMyPencils(color)
  color = color or "vague"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, --> Higher priority over other plugins
    config = function()
      require("tokyonight").setup({
        transparent = vim.g.have_transparent_bg,
        styles = {
          sidebars = vim.g.have_transparent_bg and "transparent" or "dark",
          floats = vim.g.have_transparent_bg and "transparent" or "dark",
        },
        plugins = {
          mini_statusline = true,
          mini_starter = true,
        },
      })
      -- vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        transparent = vim.g.have_transparent_bg,
      })
      -- vim.cmd.colorscheme("kanagawa-lotus")
    end,
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "cool",
        transparent = vim.g.have_transparent_bg,
      })
      -- vim.cmd.colorscheme("onedark")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = vim.g.have_transparent_bg,
        },
      })
      -- vim.cmd.colorscheme("nordfox")
    end,
  },
  {
    "vague2k/vague.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("vague").setup({
        transparent = true,
      })
      -- vim.cmd.colorscheme 'vague'
    end,
  },
  -- Using Lazy
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    opts = {},
    config = function()
      require("solarized-osaka").setup({
        options = {
          transparent = vim.g.have_transparent_bg,
        },
      })
      -- vim.cmd.colorscheme 'solarized-osaka'
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      -- vim.cmd.colorscheme 'vscode'
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        styles = {
          italic = false,
        },
      })

      vim.cmd.colorscheme("rose-pine-moon")
    end,
  },
}
