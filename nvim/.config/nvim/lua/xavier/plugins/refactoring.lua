---@diagnostic disable, 113: 113
return {
    {
        "theprimeagen/refactoring.nvim",
        config = function()
            require("refactoring").setup()
            vim.keymap.set("n", "<leader>rr", function()
                vim.api.nvim_set_keymap("v", "<leader>rr", ":lua require('refactoring').select_refactor()<CR>", {
                    noremap = true,
                    silent = true,
                    expr = false,
                })
                vim.api.nvim_set_keymap(
                    "v",
                    "<leader>ri",
                    [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
                    {
                        noremap = true,
                        silent = true,
                        expr = false,
                    }
                )
            end)
        end,
    },
}