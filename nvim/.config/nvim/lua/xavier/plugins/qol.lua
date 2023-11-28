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
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async'
    },
    opts = {},
    config = function()
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      })
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end
  },
  {
    'mbbill/undotree',
    opts = {},
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },
  {
    'folke/trouble.nvim',
    config = function()
      require("trouble").setup({
        icons = false
      })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true }
      )
    end
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup({})
    end
  }
}
