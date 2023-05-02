-- Core
return {{
    "svrana/neosolarized.nvim",
    dependencies = {"tjdevries/colorbuddy.nvim"},
    lazy = false
},
{"tpope/vim-surround"}, {"tpope/vim-repeat"}, {"tpope/vim-fugitive"}, {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
}, {"nvim-treesitter/playground"}, {"theprimeagen/harpoon"}, {"theprimeagen/refactoring.nvim"}, {"mbbill/undotree"},
        {"nvim-treesitter/nvim-treesitter-context"}}
