return {
    {
        "svrana/neosolarized.nvim",
        dependencies = {
            "tjdevries/colorbuddy.nvim"
        },
        lazy = false
    },
    {
        "tpope/vim-surround"
    },
    {
        "tpope/vim-repeat"
    },
    {
        "tpope/vim-fugitive"
    },
    { "kshenoy/vim-signature" },
    { 'unblevable/quick-scope' }, { "mg979/vim-visual-multi" },
    { 'justinmk/vim-sneak' },
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    },
    {
        "nvim-treesitter/playground"
    },
    {
        "theprimeagen/harpoon"
    },
    {
        "theprimeagen/refactoring.nvim"
    },
    {
        "mbbill/undotree"
    },
    {
        "folke/trouble.nvim"
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    },
    {
        "nvim-telescope/telescope-ui-select.nvim"
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        }
    },
    {
        "akinsho/nvim-bufferline.lua"
    },
    {
        "nvim-lualine/lualine.nvim"
    },
    {
        "onsails/lspkind-nvim"
    },
    {
        "hrsh7th/cmp-buffer"
    },
    {
        "hrsh7th/nvim-cmp"
    },
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "neovim/nvim-lspconfig"
    }, {
    "L3MON4D3/LuaSnip"
},

    {
        "jose-elias-alvarez/null-ls.nvim"
    },
    {
        "williamboman/mason.nvim"
    },
    {
        "williamboman/mason-lspconfig.nvim"
    },
    {
        'glepnir/lspsaga.nvim', event = "LspAttach"
    },
    {
        "windwp/nvim-autopairs"
    },
    {
        "windwp/nvim-ts-autotag"
    },
    { "github/copilot.vim" },
};
