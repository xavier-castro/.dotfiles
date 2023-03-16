---@diagnostic disable: undefined-global
return { 'no-clown-fiesta/no-clown-fiesta.nvim', priority = 1000, lazy = false,
    config = function()
        vim.cmd [[colorscheme no-clown-fiesta]]
    end}

