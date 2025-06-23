-- [[ ChadRC Configuration ]]
-- This file provides NvChad-specific configuration
-- Required by NvChad's theme system and UI components

local M = {}

-- UI Configuration
M.ui = {
  theme = "nightfox", -- Default theme, can be changed via theme picker
  theme_toggle = { "nightfox", "one_light" },

  -- Transparency settings
  transparency = false,

  -- Statusline configuration
  statusline = {
    enabled = false,
    theme = "minimal", -- default/vscode/vscode_colored/minimal
    separator_style = "block", -- default/round/block/arrow
  },

  -- Tabufline (buffer line) configuration
  tabufline = {
    enabled = false,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },

  -- nvdash (dashboard) configuration
  nvdash = {
    load_on_startup = true,
  },

  -- cheatsheet configuration
  cheatsheet = {
    theme = "grid", -- simple/grid
  },

  -- lsp semantic tokens
  lsp_semantic_tokens = false,

  -- cmp theming
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
  },

  -- telescope style
  telescope = { style = "borderless" }, -- borderless / bordered

  -- nvcheatsheet config
  nvcheatsheet = {
    theme = "grid", -- simple/grid
  },
}

-- Base46 theme configuration
M.base46 = {
  theme = "nightfox",
  hl_override = {},
  hl_add = {},
  integrations = {},
  changed_themes = {},
  transparency = false,
}

-- Terminal configuration
M.term = {
  winopts = { number = false, relativenumber = false },
  sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = "single",
  },
}

-- Mappings configuration (optional, we use our own in keymaps.lua)
M.mappings = {}

-- Plugin configurations (we handle these in our plugin files)
M.plugins = {}

return M
