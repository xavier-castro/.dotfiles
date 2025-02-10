-- Basic VSCode-specific keymaps
local vscode = require('vscode-neovim')
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Helper function for keymaps
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- VSCode specific keymaps
map('n', 'gd', function() vscode.action('editor.action.revealDefinition') end)
map('n', 'gr', function() vscode.action('editor.action.goToReferences') end)
map('n', 'gi', function() vscode.action('editor.action.goToImplementation') end)
map('n', 'K', function() vscode.action('editor.action.showHover') end)

-- Navigation
map('n', ']d', function() vscode.action('editor.action.marker.next') end)
map('n', '[d', function() vscode.action('editor.action.marker.prev') end)

-- Search
map('n', '<leader>f', function() vscode.action('workbench.action.quickOpen') end)
map('n', '<leader>F',
    function() vscode.action('workbench.action.findInFiles') end)

-- Window navigation
map('n', '<C-j>', function() vscode.action('workbench.action.navigateDown') end)
map('n', '<C-k>', function() vscode.action('workbench.action.navigateUp') end)
map('n', '<C-h>', function() vscode.action('workbench.action.navigateLeft') end)
map('n', '<C-l>', function() vscode.action('workbench.action.navigateRight') end)

-- Basic settings
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- But case-sensitive if contains capital letter
vim.opt.lead

-- Additional useful functions
local M = {}

-- Toggle comment
M.toggle_comment = function() vscode.action('editor.action.commentLine') end

-- Format document
M.format_document = function() vscode.action('editor.action.formatDocument') end

-- Rename symbol
M.rename_symbol = function() vscode.action('editor.action.rename') end

-- Add corresponding keymaps
map('n', 'gcc', M.toggle_comment)
map('v', 'gc', M.toggle_comment)
map('n', '<leader>r', M.rename_symbol)
map('n', '<leader>f', M.format_document)

-- Workspace commands
map('n', '<leader>wa',
    function() vscode.action('workbench.action.findInFiles') end)
map('n', '<leader>wr',
    function() vscode.action('workbench.action.replaceInFiles') end)


-- In your vscode.lua or similar VSCode-specific config file

-- Helper function for keymaps
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- VSCode completion trigger
map('i', '<C-f>', function()
    vim.fn.VSCodeNotify('editor.action.triggerSuggest')
end)

-- Optional: Add more VSCode completion related keymaps
map('i', '<C-Space>', function()
    vim.fn.VSCodeNotify('editor.action.triggerSuggest')
end)

-- Navigate completion menu
map('i', '<C-j>', function()
    vim.fn.VSCodeNotify('selectNextSuggestion')
end)
map('i', '<C-k>', function()
    vim.fn.VSCodeNotify('selectPrevSuggestion')
end)
