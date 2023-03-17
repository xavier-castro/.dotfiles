---@diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end
    },
    {
        'altermo/ultimate-autopair.nvim',
        event = { 'InsertEnter', 'CmdlineEnter' },
        config = function()
            require('ultimate-autopair').setup({})
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { 'rose-pine/neovim',                          name = 'rose-pine' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            "windwp/nvim-ts-autotag",
        }
    },
    { 'theprimeagen/harpoon' },
    { "ThePrimeagen/refactoring.nvim" },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-surround' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },                  -- Required
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
            { 'hrsh7th/cmp-buffer' },                -- Optional
            { 'hrsh7th/cmp-path' },                  -- Optional
            { 'saadparwaiz1/cmp_luasnip' },          -- Optional
            { 'hrsh7th/cmp-nvim-lua' },              -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },                  -- Required
            { 'rafamadriz/friendly-snippets' }       -- Optional
        }
    },
    {
        "zbirenbaum/copilot.lua",
        keys = {
            {
                "n",
                "<leader>cpat",
                ":Copilot suggestion toggle_auto_trigger<cr>",
                desc = { "Toggle Auto Trigger" }
            },
            {
                "n,i",
                "<M-l>",
                ":Copilot panel<cr>",
                desc = { "Toggle Copilot panel" }
            }
        },
        event = { "VimEnter" }
    },
    { "lewis6991/gitsigns.nvim", config = function() require('gitsigns').setup({}) end },
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
    },
    { "folke/zen-mode.nvim" },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                icons = false,
            }
        end
    },
    {"laytan/cloak.nvim"}
}, opts)
