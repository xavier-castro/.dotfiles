return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {{{"nvim-tree/nvim-web-devicons"}}},
        config = function()
            require("nvim-tree").setup({
                diagnostics = {enable = true},
                view = {width = 30, side = "left", signcolumn = "no"},
                git = {enable = true, ignore = false, timeout = 500},
                actions = {open_file = {quit_on_open = true}},
                renderer = {
                    group_empty = true,
                    highlight_opened_files = "all",
                    special_files = {},
                    root_folder_modifier = ":p:~"
                }
            })

            -- Mappings
            vim.keymap
                .set("n", "<C-b>", vim.cmd.NvimTreeToggle, {silent = true})
        end
    }
}
