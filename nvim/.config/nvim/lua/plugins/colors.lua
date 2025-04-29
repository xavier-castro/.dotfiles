function ColorMyPencils(color)
  color = color or "rose-pine-moon"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      styles = {
        transparency = true,
        italic = false,
      },
    },
    config = function()
      ColorMyPencils()
    end,
    -- opts = {
    --   dark_variant = "moon",
    --   styles = { italic = false },
    --   palette = {
    --     dawn = {
    --       no_bg = "#faf4ed",
    --       cursor_bg = "#000000",
    --       cursor_fg = "#ffffff",
    --     },
    --     moon = {
    --       gold = "#f6d5a7",
    --       foam = "#a1d1da",
    --       iris = "#d9c7ef",
    --       rose = "#ebbcba",
    --       pine = "#437e91",
    --       no_bg = "#000000",
    --       cursor_bg = "#ffffff",
    --       cursor_fg = "#000000",
    --     },
    --   },
    --   highlight_groups = {
    --     Normal = { bg = "no_bg" },
    --     Cursor = { bg = "cursor_bg", fg = "cursor_fg" },
    --     Directory = { fg = "foam", bold = false },
    --     StatusLine = { bg = "surface", fg = "subtle" },
    --     StatusLineTerm = { link = "StatusLine" },
    --     StatusLineNC = { link = "StatusLine" },
    --     --- gitsigns
    --     StatusLineGitSignsAdd = { bg = "surface", fg = "pine" },
    --     StatusLineGitSignsChange = { bg = "surface", fg = "gold" },
    --     StatusLineGitSignsDelete = { bg = "surface", fg = "rose" },
    --     --- diagnostics
    --     StatusLineDiagnosticSignError = { bg = "surface", fg = "love" },
    --     StatusLineDiagnosticSignWarn = { bg = "surface", fg = "gold" },
    --     StatusLineDiagnosticSignInfo = { bg = "surface", fg = "foam" },
    --     StatusLineDiagnosticSignHint = { bg = "surface", fg = "iris" },
    --     StatusLineDiagnosticSignOk = { bg = "surface", fg = "pine" },
    --   },
    -- },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    opts = {},
    config = function()
      -- Lua:
      -- For dark theme (neovim's default)
      vim.o.background = "dark"
      -- For light theme
      -- vim.o.background = 'light'

      local c = require("vscode.colors").get_colors()
      require("vscode").setup({

        transparent = true,
      })
      -- require('vscode').load()

      -- load the theme without affecting devicon colors.
      -- vim.cmd.colorscheme "vscode"
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "rose-pine",
    },
  },
}
