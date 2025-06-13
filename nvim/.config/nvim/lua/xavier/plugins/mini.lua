return {
  'echasnovski/mini.nvim',
  version = false,
  lazy = false,
  priorirty = 1000,
  event = 'BufEnter',
  config = function()
    require('mini.bufremove').setup()
    require('mini.align').setup()
    require('mini.ai').setup {
      n_lines = 500,
    }
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()
    require('mini.files').setup()
    require('mini.misc').setup()
    require('mini.pick').setup()
    require('mini.clue').setup()
    require('mini.extra').setup()
    require('mini.diff').setup()
    require('mini.sessions').setup()
    require('mini.doc').setup()
    require('mini.fuzzy').setup()
    require('mini.starter').setup()
    require('mini.notify').setup {}
    require('mini.basics').setup()
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('mini.completion').setup()
    require('mini.cursorword').setup()
    require('mini.indentscope').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('mini.map').setup()
    require('mini.move').setup()
    require('mini.operators').setup()
    require('mini.pairs').setup()
    require('mini.splitjoin').setup()
    require('mini.statusline').setup()
    require('mini.tabline').setup()
    require('mini.trailspace').setup()

    -- Keymaps for MiniFiles (file explorer)
    vim.keymap.set('n', '-', function()
      require('mini.files').open()
    end, {
      desc = 'Open file explorer (MiniFiles)',
    })

    -- Sane keybinds for other Mini modules
    vim.keymap.set('n', '<leader>bb', function()
      require('mini.bufremove').delete()
    end, {
      desc = 'Delete buffer (MiniBufremove)',
    })
    vim.keymap.set('n', '<leader>ff', function()
      require('mini.pick').builtin.files()
    end, {
      desc = 'Find files (MiniPick)',
    })
    vim.keymap.set('n', '<leader>ss', function()
      require('mini.sessions').select()
    end, {
      desc = 'Select session (MiniSessions)',
    })
    vim.keymap.set('n', '<leader>qq', function()
      require('mini.sessions').write()
    end, {
      desc = 'Save session (MiniSessions)',
    })
    vim.keymap.set('n', '<leader>sg', function()
      require('mini.fuzzy').fuzzy_search()
    end, {
      desc = 'Fuzzy search (MiniFuzzy)',
    })
    vim.keymap.set('n', '<leader>tt', function()
      require('mini.trailspace').trim()
    end, {
      desc = 'Trim trailing whitespace (MiniTrailspace)',
    })

    -- Floating terminal toggle
    local float_term_win = nil
    local float_term_buf = nil

    local function create_floating_terminal()
      -- Create or reuse buffer
      if not float_term_buf or not vim.api.nvim_buf_is_valid(float_term_buf) then
        float_term_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(float_term_buf, 'bufhidden', 'hide')
        vim.api.nvim_buf_set_option(float_term_buf, 'filetype', 'terminal')
      end

      -- Calculate window dimensions
      local width = math.floor(vim.o.columns * 0.8)
      local height = math.floor(vim.o.lines * 0.8)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      -- Ensure minimum dimensions
      width = math.max(width, 80)
      height = math.max(height, 20)

      -- Create floating window with error handling
      local ok, win_or_err = pcall(vim.api.nvim_open_win, float_term_buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
        title = ' Terminal ',
        title_pos = 'center',
      })

      if not ok then
        vim.notify('Failed to create floating terminal: ' .. win_or_err, vim.log.levels.ERROR)
        return
      end

      float_term_win = win_or_err

      -- Set window options
      vim.api.nvim_win_set_option(float_term_win, 'winblend', 0)

      -- Start terminal if buffer is empty
      local line_count = vim.api.nvim_buf_line_count(float_term_buf)
      if line_count <= 1 and vim.api.nvim_buf_get_lines(float_term_buf, 0, -1, false)[1] == '' then
        local shell = os.getenv 'SHELL' or '/bin/sh'
        local job_id = vim.fn.termopen(shell, {
          buffer = float_term_buf,
          on_exit = function(_, exit_code)
            -- Clean up when terminal exits
            if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
              vim.api.nvim_win_close(float_term_win, true)
            end
            float_term_win = nil
            -- Only clear buffer if terminal exited normally
            if exit_code == 0 then
              float_term_buf = nil
            end
          end,
        })

        if job_id <= 0 then
          vim.notify('Failed to start terminal', vim.log.levels.ERROR)
          close_floating_terminal()
          return
        end
      end

      -- Enter insert mode
      vim.cmd 'startinsert'
    end

    local function close_floating_terminal()
      if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
        vim.api.nvim_win_close(float_term_win, true)
        float_term_win = nil
      end
    end

    vim.keymap.set('n', '<leader>ft', function()
      if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
        close_floating_terminal()
      else
        create_floating_terminal()
      end
    end, {
      desc = 'Toggle floating terminal',
    })

    -- Also add escape key mapping for the floating terminal
    vim.keymap.set('t', '<C-x>', function()
      if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
        close_floating_terminal()
      end
    end, {
      desc = 'Close floating terminal from terminal mode',
    })

    -- Auto-resize floating terminal on window resize
    vim.api.nvim_create_autocmd('VimResized', {
      group = vim.api.nvim_create_augroup('FloatingTerminalResize', {
        clear = true,
      }),
      callback = function()
        if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
          local width = math.floor(vim.o.columns * 0.8)
          local height = math.floor(vim.o.lines * 0.8)
          local row = math.floor((vim.o.lines - height) / 2)
          local col = math.floor((vim.o.columns - width) / 2)

          -- Ensure minimum dimensions
          width = math.max(width, 80)
          height = math.max(height, 20)

          -- Update window configuration with error handling
          local ok, err = pcall(vim.api.nvim_win_set_config, float_term_win, {
            relative = 'editor',
            width = width,
            height = height,
            row = row,
            col = col,
          })

          if not ok then
            vim.notify('Failed to resize floating terminal: ' .. err, vim.log.levels.WARN)
          end
        end
      end,
    })

    -- Setup mini.clue for keybinding clues
    require('mini.clue').setup {
      triggers = { -- Leader triggers
        {
          mode = 'n',
          keys = '<Leader>',
        },
        {
          mode = 'x',
          keys = '<Leader>',
        }, -- File explorer
        {
          mode = 'n',
          keys = '-',
        },
      },
      clues = { -- MiniFiles
        {
          mode = 'n',
          keys = '-',
          desc = 'Open file explorer (MiniFiles)',
        }, -- MiniBufremove
        {
          mode = 'n',
          keys = '<leader>bb',
          desc = 'Delete buffer (MiniBufremove)',
        }, -- MiniPick
        {
          mode = 'n',
          keys = '<leader>ff',
          desc = 'Find files (MiniPick)',
        }, -- MiniSessions
        {
          mode = 'n',
          keys = '<leader>ss',
          desc = 'Select session (MiniSessions)',
        },
        {
          mode = 'n',
          keys = '<leader>qq',
          desc = 'Save session (MiniSessions)',
        }, -- MiniFuzzy
        {
          mode = 'n',
          keys = '<leader>/',
          desc = 'Fuzzy search (MiniFuzzy)',
        }, -- MiniComment
        {
          mode = 'n',
          keys = '<leader>cc',
          desc = 'Toggle comment (MiniComment)',
        }, -- MiniTrailspace
        {
          mode = 'n',
          keys = '<leader>tt',
          desc = 'Trim trailing whitespace (MiniTrailspace)',
        }, -- Floating terminal
        {
          mode = 'n',
          keys = '<leader>ft',
          desc = 'Toggle floating terminal',
        },
        {
          mode = 't',
          keys = '<C-x>',
          desc = 'Close floating terminal',
        }, -- Add more clues as needed for other Mini modules
      },
      window = {
        delay = 200,
      },
    }
  end,
}
