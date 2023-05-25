if vim.g.vscode then
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git", "clone", "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git", "--branch=stable",
            lazypath
        })
    end
    vim.opt.rtp:prepend(lazypath)
    vim.g.mapleader = " "
    vim.cmd([[
" Workaround for gk/gj
nnoremap gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
nnoremap gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
  ]])
    vim.keymap.set("n", "<leader>y", '"+y')
    vim.keymap.set("v", "<leader>y", '"+y')
    vim.keymap.set("n", "<leader>Y", '"+Y')
    vim.keymap.set("n", "<leader>d", '"_d')
    vim.keymap.set("v", "<leader>d", '"_d')
    vim.keymap.set("v", "K", ":m '<0<CR>gv=gv")
    vim.keymap.set("v", "J", ":m '>+3<CR>gv=gv")
    vim.keymap.set("n", "J", "mzJ`z")
    vim.keymap.set("n", "<C-a>", "gg<S-v>G")
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:bd!<cr>")
    vim.keymap.set("i", "<c-s>", "<Esc>:w<CR>a")
    vim.keymap.set("n", "<c-s>", ":w<CR>")
    vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
    vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
    vim.keymap.set("n", "<Tab>",
                   "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>",
                   {})
    vim.keymap.set("n", "<S-Tab>",
                   "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>",
                   {})
    vim.keymap.set("i", "<C-c>", "<Esc>")
    vim.keymap.set("i", "<C-o>", "<C-o> <esc>o")
    vim.keymap.set("n", "<C-a>", "gg<S-v>G")
    -- vim.opt.shell = "fish"
    vim.opt.background = "dark"
    vim.opt.updatetime = 50
    vim.opt.inccommand = "split"
    vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
    -- highlight yanked text for 200ms using the "Visual" highlight group
    vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]])
    require("lazy").setup({
        {"machakann/vim-sandwich"}, {"tpope/vim-surround"}, {
            "phaazon/hop.nvim",
            branch = "v2",
            event = "VeryLazy",
            config = function()
                local keymap = vim.api.nvim_set_keymap
                local opts = {noremap = true, silent = true}
                require("hop").setup()

                -- key-mappings
                keymap("", "s", "<cmd>HopChar1<CR>", opts)
                keymap("", "<leader>j", "<cmd>HopWordBC<CR>", opts)
                keymap("", "<leader>k", "<cmd>HopWordAC<CR>", opts)

                -- highlights
                vim.api.nvim_exec([[
                    highlight HopNextKey gui=bold guifg=#ff007c guibg=None
                    highlight HopNextKey1 gui=bold guifg=#00dfff guibg=None
                    highlight HopNextKey2 guifg=#2b8db3 guibg=None
                ]], false)
            end
        }, {"tpope/vim-repeat"}, {"justinmk/vim-sneak"},

        {"tpope/vim-commentary"}
    })
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
else
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git", "clone", "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git", "--branch=stable",
            lazypath
        })
    end
    vim.opt.rtp:prepend(lazypath)
    vim.g.mapleader = " "

    require("xavier.config.set")
    require("xavier.config.remap");
    (require("lazy")).setup("xavier.plugins")
end
