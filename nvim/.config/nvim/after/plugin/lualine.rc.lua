local theme = vim.g.colors_name
local lualine = require('lualine')
local function window()
  return vim.api.nvim_win_get_number(0)
end -- test

local gruvbox_colors = {
  fg     = '#ebdbb2',
  fg2    = '#a89984',
  bg     = '#282828',
  bg2    = '#3c3836',
  black  = '#282828',
  red    = '#fb4934',
  green  = '#b8bb26',
  blue   = '#83a598',
  yellow = '#fe8019',
}

local tokyodark_colors = {
  fg     = "#a0a8cd",
  bg     = "#111219",
  bg2    = "#1a1b27",
  fg2    = "#4a5057",
  black  = "#06080a",
  red    = "#ee6d85",
  yellow = "#d7a65f",
  green  = "#95c561",
  blue   = "#7199ee",
}

local minimal_colors = {
  fg     = '#DFE0EA',
  fg2    = '#6e7380',
  bg     = '#191b20',
  bg2    = '#21252d',
  black  = '#16181d',
  red    = '#E85A84',
  green  = '#94DD8E',
  blue   = '#7eb7e6',
  yellow = '#E9D26C',
}

local kanagawa_colors = {
  fg     = '#DCD7BA',
  fg2    = '#727169',
  bg     = '#1f1f28',
  bg2    = '#2a2a37',
  black  = '#16161d',
  green  = '#98bb6c',
  yellow = '#ffa066', -- yellow/orange
  red    = '#ff5d62',
  blue   = '#7E9Cd8',
}

-- Required colors in theme:
-- fg := lighter text color
-- fg2 := darker text color
-- bg := center color
-- bg2 := different background color
-- black := darkest color for foreground of highlighted text
-- green, yellow, red, blue := colors from palette

-- local _colors = {
--     fg     = '',
--     fg2    = '',
--     bg     = '',
--     bg2    = '',
--     black  = '',
--     green  = '',
--     yellow = '', -- yellow/orange
--     red    = '',
--     blue   = '',
-- }


local colors = {}
if theme == "gruvbox" then
  colors = gruvbox_colors
elseif theme == "tokyodark" then
  colors = tokyodark_colors
elseif theme == "minimal" then
  colors = minimal_colors
elseif theme == "kanagawa" then
  colors = kanagawa_colors
else
  colors = tokyodark_colors
end

local THEME = {
  normal  = {
    a = { fg = colors.black, bg = colors.green, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg2 },
    c = { fg = colors.fg2, bg = colors.bg },
    x = { fg = colors.fg2, bg = colors.bg },
    y = { fg = colors.fg, bg = colors.bg2 },
    z = { fg = colors.fg, bg = colors.bg2 },
  },
  visual  = { a = { fg = colors.black, bg = colors.yellow, gui = "bold" } },
  replace = { a = { fg = colors.black, bg = colors.red, gui = "bold" } },
  insert  = { a = { fg = colors.black, bg = colors.blue, gui = "bold" } },
  command = { a = { fg = colors.black, bg = colors.green, gui = "bold" } },
}

local config = {
  options = {
    icons_enabled = true,
    theme = THEME,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    -- '' '' '' ''
    disabled_filetypes = {
      statusline = {
        'NvimTree',
        'alpha'
      },
      winbar = {
        'NvimTree',
        'alpha'
      },
      NvimTree = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },

  sections = {
    lualine_a = { 'mode' },
    lualine_b = {}, --{ 'branch', 'diff', 'diagnostics', }
    lualine_c = { 'filename' },
    lualine_x = { require('auto-session-library').current_session_name, },
    lualine_y = { 'fileformat', 'filetype', },
    lualine_z = { 'os.date("%H:%M")' },
  },
  tabline = {},
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        'filename',
        separator = { left = ' ', right = ' ' },
      }
    },
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        'filename',
        separator = { left = ' ', right = ' ' },
      }
    },
    lualine_z = {},
  },
  extensions = {}
}


local function ins_b(component)
  table.insert(config.sections.lualine_b, component)
end

local function ins_x(component)
  table.insert(config.sections.lualine_x, component)
end

ins_b {
  'branch',
}
ins_b {
  'diff',
  symbols = { added = ' ', modified = '柳', removed = ' ' }, -- why is the symbol for modified so weird
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
}

ins_b {
  'diagnostics',
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

ins_x {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = colors.fg2, gui = 'bold' },
}

require('lualine').setup(config)
