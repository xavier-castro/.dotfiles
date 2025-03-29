local M = {}

function M.setup()
  local saga = require('lspsaga')
  
  saga.setup({
    -- Finder configuration
    finder = {
      max_height = 0.5,
      min_width = 30,
      force_max_height = false,
      keys = {
        jump_to = "p",
        expand_or_jump = "o",
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = {"q", "<ESC>"},
      },
    },
    
    -- UI customization
    ui = {
      -- Border type can be: 'single', 'double', 'rounded', 'solid', 'shadow'
      border = 'rounded',
      winblend = 0,
      code_action = "",
    },
    
    -- Lightbulb configuration (shows when code actions are available)
    lightbulb = {
      enable = true,
      enable_in_insert = true,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
    },
    
    -- Symbol outline configuration
    outline = {
      win_position = 'right',
      win_width = 30,
      auto_preview = true,
      detail = true,
      auto_close = true,
      close_after_jump = false,
      keys = {
        jump = "o",
        expand_collapse = "u",
        quit = "q",
      },
    },
    
    -- Callhierarchy configuration
    callhierarchy = {
      show_detail = true,
      keys = {
        edit = "e",
        vsplit = "s",
        split = "i",
        tabe = "t",
        jump = "o",
        quit = "q",
        expand_collapse = "u",
      },
    },
    
    -- Diagnostic configuration
    diagnostic = {
      show_code_action = true,
      show_source = true,
      jump_num_shortcut = true,
      keys = {
        exec_action = "o",
        quit = "q",
        go_action = "g"
      },
    },
    
    -- Rename configuration
    rename = {
      quit = "<C-c>",
      exec = "<CR>",
      mark = "x",
      confirm = "<CR>",
      in_select = true,
    },
    
    -- Hover configuration
    hover = {
      max_width = 0.5,
      open_link = "gx",
      open_browser = "!chrome",
    },
  })
end

M.setup()

return M