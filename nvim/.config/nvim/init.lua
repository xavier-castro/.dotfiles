if vim.g.vscode then
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
                       "--branch=stable", -- latest stable release
        lazypath})
    end
    vim.opt.rtp:prepend(lazypath)

    vim.api.nvim_exec([[
    " THEME CHANGER
    function! SetCursorLineNrColorInsert(mode)
        " Insert mode: blue
        if a:mode == "i"
            call VSCodeNotify('nvim-theme.insert')

        " Replace mode: red
        elseif a:mode == "r"
            call VSCodeNotify('nvim-theme.replace')
        endif
    endfunction

    augroup CursorLineNrColorSwap
        autocmd!
        autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
        autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
        autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
        autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
        autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
    augroup END
]], false)
    vim.api.nvim_exec([[
    function! s:manageEditorSize(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
    endfor
endfunction

" Sample keybindings. Note these override default keybindings mentioned above.
nnoremap <C-w>> <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
xnoremap <C-w>> <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
nnoremap <C-w>+ <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
xnoremap <C-w>+ <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
nnoremap <C-w>< <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
xnoremap <C-w>< <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
nnoremap <C-w>- <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
xnoremap <C-w>- <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
   ]], false)

    require("vscode.vscode-maps")
    require("vscode.vscode-options")
    require("lazy").setup({{"tpope/vim-surround"}, {"tpope/vim-repeat"}, {
        "tpope/vim-commentary",
        config = function()
            vim.api.nvim_exec([[
                xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine
]], false)
        end
    }, {
        "dpayne/CodeGPT.nvim",
        dependencies = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"},
        config = function()
            require("codegpt.config")
        end
    }, {
        'asvetliakov/vim-easymotion',
        config = function()
            vim.api.nvim_exec([[
            map <Leader><Leader> <Plug>(easymotion-prefix)
            ]], false)
        end
    }})

else
    ---@diagnostic disable: undefined-global
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
                       "--branch=stable", -- latest stable release
        lazypath})
    end
    vim.opt.rtp:prepend(lazypath)
    require("lazy").setup("xavier.plugins", opts)
end
