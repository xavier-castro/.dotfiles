return {
  {
    'echasnovski/mini.notify',
    lazy = false,
    config = function()
      local opts = {
        ERROR = { duration = 5000, hl_group = 'DiagnosticError' },
        WARN = { duration = 5000, hl_group = 'DiagnosticWarn' },
        INFO = { duration = 5000, hl_group = 'DiagnosticInfo' },
        DEBUG = { duration = 0, hl_group = 'DiagnosticHint' },
        TRACE = { duration = 0, hl_group = 'DiagnosticOk' },
        OFF = { duration = 0, hl_group = 'MiniNotifyNormal' },
      }
      require('mini.notify').setup(opts)
      vim.notify = require('mini.notify').make_notify()

      vim.keymap.set('n', '<Leader>nc', function()
        vim.cmd.lua 'MiniNotify.clear()'
      end, { silent = true, desc = 'Clear all the notification' })
      vim.keymap.set('n', '<Leader>nh', function()
        vim.cmd.lua 'MiniNotify.show_history()'
      end, { silent = true, desc = 'Replay all the notification' })
    end,
  },
  {
    'echasnovski/mini.files',
    version = false,
    config = function()
      require('mini.files').setup()

      vim.keymap.set('n', '<Leader>e', function()
        MiniFiles.open()
      end, { silent = true, desc = 'Opens mini.files' })

      vim.keymap.set('n', '<Leader>E', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      end, { silent = true, desc = 'Opens mini.files in currect dir' })

      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local cur_target = MiniFiles.get_explorer_state().target_window
          local new_target = vim.api.nvim_win_call(cur_target, function()
            vim.cmd(direction .. ' split')
            return vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target)
          MiniFiles.go_in()
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, '<C-s>', 'belowright horizontal')
          map_split(buf_id, '<C-v>', 'belowright vertical')
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowOpen',
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set('n', '<Leader>q', function()
            vim.cmd.norm 'q'
          end, { buffer = buf_id })
        end,
      })
    end,
  },

  {
    'echasnovski/mini.hipatterns',
    version = false,
    opts = {},
  },
}
