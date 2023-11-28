return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    config = function()
      vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
      vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
      vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
      vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
    end,
  },
  {
    "windwp/nvim-autopairs",
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp', "windwp/nvim-ts-autotag" },
    config = function()
      require("nvim-autopairs").setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      require("nvim-ts-autotag").setup({})
    end,
  }
}
