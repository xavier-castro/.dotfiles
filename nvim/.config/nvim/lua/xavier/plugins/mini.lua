return {
    'echasnovski/mini.nvim',
    version = false,
    lazy = false,
    priorirty = 1000,
    config = function()
        require('mini.bufremove').setup()
        require('mini.align').setup()
        require('mini.ai').setup()
        require('mini.files').setup()
        require('mini.misc').setup()
        require('mini.pick').setup()
        require('mini.clue').setup()
        require('mini.extra').setup()
        require('mini.diff').setup()
        require('mini.sessions').setup()
        require('mini.doc').setup()
        require('mini.fuzzy').setup()
        require('mini.starter').setup()
        require('mini.notify').setup()
        require('mini.animate').setup()
        require('mini.basics').setup()
        require('mini.bracketed').setup()
        require('mini.comment').setup()
        require('mini.completion').setup()
        require('mini.cursorword').setup()
        require('mini.hues').setup()
        local hues = require('mini.hues')
        local fg = hues.get_colors().fg
        local bg = hues.get_colors().bg
        print("(fg: " .. fg .. ", bg: " .. bg .. ")")
        require('mini.indentscope').setup()
        require('mini.jump').setup()
        require('mini.jump2d').setup()
        require('mini.map').setup()
        require('mini.move').setup()
        require('mini.operators').setup()
        require('mini.pairs').setup()
        require('mini.splitjoin').setup()
        require('mini.statusline').setup()
        require('mini.surround').setup()
        require('mini.tabline').setup()
        require('mini.trailspace').setup()

        vim.cmd.colorscheme 'randomhue'
    end
}
