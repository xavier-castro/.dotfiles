return {
  'folke/snacks.nvim',
  keys = {
    {
      '<leader>gg',
      function()
        require('snacks').lazygit.open()
      end,
      desc = 'Open LazyGit',
    },
    {
      '<leader>uc',
      function()
        require('snacks').zen()
      end,
      desc = 'Toggle center mode',
    },
  },
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    lazygit = { enabled = true },
    statuscolumn = { enabled = true },
    zen = { enabled = true, toggles = { dim = false } },
    quickfile = { enabled = true },

    explorer = { enabled = false, replace_netrw = false },
    dashboard = { enabled = false },
    scroll = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = false },
    words = { enabled = false },
  },
}
