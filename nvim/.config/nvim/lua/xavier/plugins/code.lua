return {
  { 'tpope/vim-repeat', keys = { { '.' }, { ';' } } },
  {
    'Exafunction/windsurf.vim',
    event = 'BufEnter',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-;>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-,>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true })
    end,
  },

  -- opposite and increment/decrement
  {
    'nat-418/boole.nvim',
    keys = { { '<C-a>' }, { '<C-x>' } },
    opts = {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
    },
  },
  -- UndotreeToggle
  {
    'mbbill/undotree',
    keys = {
      { '<leader>gu', '<cmd>UndotreeToggle<CR>', desc = 'Toggle undotree' },
    },
  },

  -- Generate documentation
  {
    'danymat/neogen',
    config = true,
    keys = {
      {
        '<leader>cn',
        function()
          require('neogen').generate {}
        end,
        desc = 'Generate func|class|type documentation',
      },
    },
  },

  {
    'andrewferrier/debugprint.nvim',
    opts = {},
    keys = {
      { 'g?v', mode = { 'n', 'x' }, desc = 'Veriable log' },
      { 'g?V', mode = { 'n', 'x' }, desc = 'Veriable log above' },
      { 'g?p', mode = { 'n', 'x' }, desc = 'Plain debug log below' },
      { 'g?P', mode = { 'n', 'x' }, desc = 'Plain debug log below' },
    },
    version = '*',
  },
}
