local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- CORE START --
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'lewis6991/impatient.nvim'
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use { 'craftzdog/neosolarized.nvim', requires = { 'tjdevries/colorbuddy.nvim' } }
  use 'MunifTanjim/prettier.nvim'
  -- CORE END --

  -- CMP START --
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'b0o/schemastore.nvim'
  use 'akinsho/nvim-bufferline.lua'
  use {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require "xavier.copilot"
      end, 100)
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup({
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing
        }
      })
    end
  }
  -- CMP END --

  -- LSP START --
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use "folke/trouble.nvim"
  -- LSP END --

  -- SNIPPETS START --
  use { "L3MON4D3/LuaSnip", wants = { "friendly-snippets", "vim-snippets" } }
  use "rafamadriz/friendly-snippets"
  use "honza/vim-snippets"
  -- SNIPPETS END --

  -- TREESITTER START --
  use({ 'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end })
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "nvim-treesitter/playground"
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'andymass/vim-matchup'
  -- TREESITTER END --

  -- NAVIGATION RELATED START --
  use 'ThePrimeagen/harpoon'
  use 'ThePrimeagen/refactoring.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use "ahmedkhalf/project.nvim"
  use "goolord/alpha-nvim"
  use 'abecodes/tabout.nvim'
  use { 'phaazon/hop.nvim', branch = 'v2',
    config = function() require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' } end }
  use "simrat39/symbols-outline.nvim"
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }
  -- NAVIGATION RELATED END --

  -- UI QOL RELATED START --
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' } -- git client
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use "RRethy/vim-illuminate"
  use 'norcalli/nvim-colorizer.lua'
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-surround'
  use "j-hui/fidget.nvim"
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  -- UI QUOL RELATED END --
end)
