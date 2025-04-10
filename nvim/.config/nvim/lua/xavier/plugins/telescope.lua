return {
  'nvim-telescope/telescope.nvim',

  tag = '0.1.5',

  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  config = function()
    require('telescope').setup {}

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
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

    -- keymaps
    vim.keymap.set('n', ';f', function()
      builtin.find_files {
        no_ignore = false,
        hidden = true,
      }
    end)
    vim.keymap.set('n', ';r', function()
      builtin.live_grep()
    end)
    vim.keymap.set('n', '\\\\', function()
      builtin.buffers()
    end)
    vim.keymap.set('n', ';t', function()
      builtin.help_tags()
    end)
    vim.keymap.set('n', ';;', function()
      builtin.resume()
    end)
    vim.keymap.set('n', ';e', function()
      builtin.diagnostics()
    end)
    vim.keymap.set('n', ';o', function()
      builtin.oldfiles()
    end)
  end,
}
