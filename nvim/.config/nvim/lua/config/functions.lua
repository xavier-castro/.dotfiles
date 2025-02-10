local M = {}

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

function M.toggleInlayHints()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end

keymap.set('n', '<leader>i', function()
    toggleInlayHints()
end)

function M.ColorMyPencils(color)
    color = color or 'tokyonight-storm'
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
end

M.ColorMyPencils()

return M
