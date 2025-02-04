return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = false,
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}

      -- File Operations
      vim.keymap.set('n', '<leader>hm', function()
        harpoon:list():append()
      end, { desc = 'Harpoon: Add current file' })
      vim.keymap.set('n', '<leader>ha', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon: List all Harpoon files' })

      -- File Selection
      vim.keymap.set('n', '<leader>hh', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon: Select Harpoon file 1' })
      vim.keymap.set('n', '<leader>hj', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon: Select Harpoon file 2' })
      vim.keymap.set('n', '<leader>hk', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon: Select Harpoon file 3' })
      vim.keymap.set('n', '<leader>hl', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon: Select Harpoon file 4' })

      vim.keymap.set('n', '<leader>hda', function()
        harpoon:list():clear()
      end, { desc = 'Harpoon: Clear all Harpoon files' })
      vim.keymap.set('n', '<leader>hdh', function()
        harpoon:list():removeAt(1)
      end, { desc = 'Harpoon: Clear Harpoon file 1' })
      vim.keymap.set('n', '<leader>hdj', function()
        harpoon:list():removeAt(2)
      end, { desc = 'Harpoon: Clear Harpoon file 2' })
      vim.keymap.set('n', '<leader>hdk', function()
        harpoon:list():removeAt(3)
      end, { desc = 'Harpoon: Clear Harpoon file 3' })
      vim.keymap.set('n', '<leader>hdl', function()
        harpoon:list():removeAt(4)
      end, { desc = 'Harpoon: Clear Harpoon file 4' })
    end,
  },
}
