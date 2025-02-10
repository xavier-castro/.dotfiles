return {
  lazy = false,
  event = 'BufEnter',
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  keys = {
    {
      ';;',
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
      ';h',
      function()
        local builtin = require 'telescope.builtin'
        builtin.help_tags()
      end,
      desc = 'Lists available help tags and opens a new window with the relevant help info on <cr>',
    },
    {
      ';d',
      function()
        local builtin = require 'telescope.builtin'
        builtin.diagnostics()
      end,
      desc = 'Lists Diagnostics for all open buffers or a specific buffer',
    },
    -- Telescope buffers
    {
      ';b',
      function()
        local builtin = require 'telescope.builtin'
        builtin.buffers()
      end,
      desc = 'Lists open buffers',
    },
    {
      ';o',
      function()
        local builtin = require 'telescope.builtin'
        builtin.oldfiles()
      end,
      desc = 'List Oldfiles',
    },
  },
  config = function()
    local fb_actions = require 'telescope._extensions.file_browser.actions'

    require('telescope').setup {
      defaults = {
        wrap_results = true,
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        winblend = 0,
      },
      pickers = {
        diagnostics = {
          theme = 'ivy',
          initial_mode = 'normal',
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      },
      extensions = {
        file_browser = {
          theme = 'dropdown',
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
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
              -- ['<PageUp>'] = actions.preview_scrolling_up,
              -- ['<PageDown>'] = actions.preview_scrolling_down,
            },
          },
        },
      },
    }
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string { search = vim.fn.input 'Grep > ' }
    end)
    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'file_browser'
    -- open file_browser with the path of the current buffer
    -- vim.keymap.set("n", ";;", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
  end,
}
