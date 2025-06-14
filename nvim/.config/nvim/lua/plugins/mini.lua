return {
  {
    'echasnovski/mini.nvim',
    dependencies = {"https://github.com/rafamadriz/friendly-snippets"},
    config = function()
      require('mini.basics').setup()
      require('mini.ai').setup()
      require('mini.clue').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.keymap').setup()
      require('mini.align').setup()
      require('mini.bracketed').setup()
      require('mini.bufremove').setup()

      -- MARK: UI START
      require('mini.colors').setup()
      require('mini.statusline').setup({ use_icons = false })
      require('mini.indentscope').setup()
      require('mini.map').setup()
      require('mini.starter').setup()
      -- MARK: UI END

      -- MARK: TEXT START
      require('mini.completion').setup()
      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup({
        snippets = {
          -- Load custom file with global snippets first (adjust for Windows)
          gen_loader.from_file('~/.config/nvim/snippets/global.json'),

          -- Load snippets based on current language by reading files from
          -- "snippets/" subdirectories from 'runtimepath' directories.
          gen_loader.from_lang(),
        },
})
      -- MARK: TEXT END
    end
  }
}
