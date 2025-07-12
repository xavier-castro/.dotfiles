return
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    lazy = false,
    priority = 1000,
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      'nvim-telescope/telescope-file-browser.nvim',
    },
    keys = {
      {
        ';f',
        function()
          local builtin = require 'telescope.builtin'
          builtin.find_files {
            no_ignore = false,
            hidden = true,
          }
        end,
        desc = 'Lists files in your current working directory, respects .gitignore',
      },
      {
        ';r',
        function()
          local builtin = require 'telescope.builtin'
          builtin.live_grep {
            additional_args = { '--hidden' },
          }
        end,
        desc = 'Search for a string in your current working directory and get results live as you type, respects .gitignore',
      },
      {
        '\\\\',
        function()
          local builtin = require 'telescope.builtin'
          builtin.buffers()
        end,
        desc = 'Lists open buffers',
      },
      {
        ';t',
        function()
          local builtin = require 'telescope.builtin'
          builtin.help_tags()
        end,
        desc = 'Lists available help tags and opens a new window with the relevant help info on <cr>',
      },
      {
        ';;',
        function()
          local builtin = require 'telescope.builtin'
          builtin.resume()
        end,
        desc = 'Resume the previous telescope picker',
      },
      {
        ';e',
        function()
          local builtin = require 'telescope.builtin'
          builtin.diagnostics()
        end,
        desc = 'Lists Diagnostics for all open buffers or a specific buffer',
      },
      {
        ';s',
        function()
          local builtin = require 'telescope.builtin'
          builtin.treesitter()
        end,
        desc = 'Lists Function names, variables, from Treesitter',
      },
      {
        ';c',
        function()
          local builtin = require 'telescope.builtin'
          builtin.lsp_incoming_calls()
        end,
        desc = 'Lists LSP incoming calls for word under the cursor',
      },
      {
        'sf',
        function()
          local telescope = require 'telescope'

          local function telescope_buffer_dir()
            return vim.fn.expand '%:p:h'
          end

          telescope.extensions.file_browser.file_browser {
            path = '%:p:h',
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = 'normal',
            layout_config = { height = 40 },
          }
        end,
        desc = 'Open File Browser with the path of the current buffer',
      },
    },
    config = function(_, opts)
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'
      local fb_actions = require('telescope').extensions.file_browser.actions

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>pws', function()
        local word = vim.fn.expand '<cword>'
        builtin.grep_string { search = word }
      end)
      vim.keymap.set('n', '<leader>pWs', function()
        local word = vim.fn.expand '<cWORD>'
        builtin.grep_string { search = word }
      end)
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string { search = vim.fn.input 'Grep > ' }
      end)
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      opts.defaults = {
        wrap_results = true,
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        winblend = 0,
        mappings = {
          n = {},
        },
      }
      opts.pickers = {
        diagnostics = {
          theme = 'ivy',
          initial_mode = 'normal',
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          theme = 'dropdown',
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = false,
          mappings = {
            -- your custom insert mode mappings
            ['n'] = {
              -- your custom normal mode mappings
              ['N'] = fb_actions.create,
              ['h'] = fb_actions.goto_parent_dir,
              ['/'] = function()
                vim.cmd 'startinsert'
              end,
              ['<C-u>'] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ['<C-d>'] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ['<PageUp>'] = actions.preview_scrolling_up,
              ['<PageDown>'] = actions.preview_scrolling_down,
            },
          },
        },
      }
      telescope.setup(opts)
      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'file_browser'
    end,
  }
