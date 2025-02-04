return {
  'echasnovski/mini.nvim',
  version = false,
  opts = {
    mappings = {
      -- Expand snippet at cursor position. Created globally in Insert mode.
      expand = '<C-f>',

      -- Interact with default `expand.insert` session.
      -- Created for the duration of active session(s)
      jump_next = '<C-j>',
      jump_prev = '<C-k>',
      stop = '<C-c>',
    },
  },
  config = function()
    local gen_loader = require('mini.snippets').gen_loader
    require('mini.snippets').setup {
      snippets = {
        -- Load custom file with global snippets first (adjust for Windows)
        gen_loader.from_file '~/.config/nvim/snippets/global.json',

        -- Load snippets based on current language by reading files from
        -- "snippets/" subdirectories from 'runtimepath' directories.
        gen_loader.from_lang(),
      },
    }
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.align').setup()
    require('mini.extra').setup()
    require('mini.sessions').setup()
    require('mini.indentscope').setup()
    require('mini.hipatterns').setup()
    require('mini.icons').setup()
    require('mini.doc').setup()
  end,
}
