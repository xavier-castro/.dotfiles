return {
    {
        -- integrate with lualine
        "nvim-lualine/lualine.nvim",
        event = { "VimEnter" },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "linrongbin16/lsp-progress.nvim",
        },
        config = function()
        end,
    },
    {
        "linrongbin16/lsp-progress.nvim",
        event = { "VimEnter" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lsp-progress").setup()
        end,
    },
}
