return {
  'matarina/pyrola.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  build = ':UpdateRemotePlugins',
  config = function(_, opts)
    local pyrola = require 'pyrola'
    pyrola.setup {
      kernel_map = { -- Map Jupyter kernel names to Neovim filetypes
        python = 'python3',
      },
      split_horizen = false, -- Define the terminal split direction
      split_ratio = 0.3, -- Set the terminal split size
    }

    -- Define key mappings for enhanced functionality
    vim.keymap.set('n', '<Enter>', function()
      pyrola.send_statement_definition()
    end, { noremap = true })

    vim.keymap.set('v', '<leader>vs', function()
      require('pyrola').send_visual_to_repl()
    end, { noremap = true })

    vim.keymap.set('n', '<leader>is', function()
      pyrola.inspect()
    end, { noremap = true })

    -- nvim_ds_repl plugin configuration --
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = { '*.py', '*.R' },
      callback = function()
        -- Execute the current statement or block under the cursor
        vim.keymap.set('n', '<CR>', function()
          require('pyrola').send_statement_definition()
        end, { noremap = true })

        -- Execute the selected visual block of code
        vim.keymap.set('v', '<leader>vs', function()
          require('pyrola').send_visual_to_repl()
        end, { noremap = true })

        -- Query information about the specific object under the cursor
        vim.keymap.set('n', '<leader>is', function()
          require('pyrola').inspect()
        end, { noremap = true })
      end,
    })

    -- Configure Treesitter for enhanced code parsing
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'cpp', 'r', 'python' }, -- Ensure the necessary Treesitter language parsers are installed
      auto_install = true,
    }
  end,
}
