local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

packer.init {
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- CORE START --
  use "lewis6991/impatient.nvim"
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'akinsho/nvim-bufferline.lua'
  use 'tjdevries/colorbuddy.nvim'
  use { "Mofiqul/vscode.nvim", config = function()
    vim.o.background = 'dark'
    local c = require('vscode.colors')
    require('vscode').setup({
      transparent = true,
      italic_comments = true,
      disable_nvimtree_bg = true,
      color_overrides = {},
      group_overrides = {
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
      },
    })
  end }
  -- use { 'craftzdog/neosolarized.nvim', requires = { 'tjdevries/colorbuddy.nvim' } }
  use 'MunifTanjim/prettier.nvim'
  -- CORE END --

  -- CMP START --
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'b0o/schemastore.nvim'
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
  use { "tzachar/cmp-tabnine", commit = "1a8fd2795e4317fd564da269cc64a2fa17ee854e",
    run = "./install.sh" }
  -- CMP END --

  -- LSP START --
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  -- LSP END --

  -- SNIPPETS START --
  use { "L3MON4D3/LuaSnip", wants = { "friendly-snippets", "vim-snippets" } }
  use "rafamadriz/friendly-snippets"
  use "honza/vim-snippets"
  use { 'saadparwaiz1/cmp_luasnip' }
  -- SNIPPETS END --

  -- TREESITTER START --
  use({ 'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end })
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use 'nvim-treesitter/nvim-treesitter-context'
  use "nvim-treesitter/playground"
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'andymass/vim-matchup'
  -- TREESITTER END --

  -- NAVIGATION RELATED START --
  use "MattesGroeger/vim-bookmarks"
  use 'ThePrimeagen/harpoon'
  use 'ThePrimeagen/refactoring.nvim'
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use "ahmedkhalf/project.nvim"
  use "goolord/alpha-nvim"
  use 'abecodes/tabout.nvim'
  use "simrat39/symbols-outline.nvim"
  use 'famiu/bufdelete.nvim'
  -- NAVIGATION RELATED END --

  -- UI QOL RELATED START --
  use 'stevearc/dressing.nvim'
  use 'levouh/tint.nvim'
  use "akinsho/toggleterm.nvim"
  use 'lewis6991/satellite.nvim'
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' } -- git client
  use "RRethy/vim-illuminate"
  use 'norcalli/nvim-colorizer.lua'
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-surround'
  use "j-hui/fidget.nvim"
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      }
    end
  }
  use 'nvim-lualine/lualine.nvim' -- Statusline
  -- UI QUOL RELATED END --
end)
