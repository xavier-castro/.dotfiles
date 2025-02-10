return {
    'echasnovski/mini.nvim',
    version = false,
    opts = {},
    config = function()
        require('mini.pairs').setup()
        require('mini.bufremove').setup()
        require('mini.icons').setup()
    end,
}
