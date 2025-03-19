return {
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = {
    transparent_background = true,
  } },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({
        -- Alternatively set style in setup
        -- style = 'light'

        -- Enable transparent background
        transparent = true,

        -- Enable italic comment
        italic_comments = true,

        -- Underline `@markup.link.*` variants
        underline_links = true,

        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,

        -- Apply theme colors to terminal
        terminal_colors = true,
      })
      -- require("vscode").load()
    end,
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      -- Lua
      require("onedark").setup({
        -- Main options --
        style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "none",
          strings = "none",
          variables = "none",
        },

        -- Lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {}, -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        -- disable_background = true,
        -- 	disable_nc_background = false,
        -- 	disable_float_background = false,
        -- extend_background_behind_borders = false,
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
        highlight_groups = {
          ColorColumn = { bg = "#1C1C21" },
          Normal = { bg = "none" }, -- Main background remains transparent
          Pmenu = { bg = "", fg = "#e0def4" }, -- Completion menu background
          PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" }, -- Highlighted completion item
          PmenuSbar = { bg = "#191724" }, -- Scrollbar background
          PmenuThumb = { bg = "#9ccfd8" }, -- Scrollbar thumb
        },
        enable = {
          terminal = false,
          legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },
      })

      -- HACK: set this on the color you want to be persistent
      -- when quit and reopening nvim
      -- vim.cmd("colorscheme rose-pine")
    end,
  },
}
