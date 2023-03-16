---@diagnostic disable: undefined-global
vim.keymap.set('n', '<leader><leader>', function()
    require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = vim.fn.expand('%:p:h'),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 40 }
    })
end)
vim.keymap.set('n', '<c-p>', ':Telescope git_files<cr>')
vim.keymap.set('n', '<leader>po', ':Telescope oldfiles initial_mode=normal<cr>')

-- Yank and keep outside of vim
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)
-- Util
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>")
