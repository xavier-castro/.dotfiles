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

        -- Keymaps for MiniFiles (file explorer)
        vim.keymap.set('n', '-', function()
            require('mini.files').open()
        end, {
            desc = 'Open file explorer (MiniFiles)'
        })

        -- Sane keybinds for other Mini modules
        vim.keymap.set('n', '<leader>bb', function()
            require('mini.bufremove').delete()
        end, {
            desc = 'Delete buffer (MiniBufremove)'
        })
        vim.keymap.set('n', '<leader>ff', function()
            require('mini.pick').builtin.files()
        end, {
            desc = 'Find files (MiniPick)'
        })
        vim.keymap.set('n', '<leader>ss', function()
            require('mini.sessions').select()
        end, {
            desc = 'Select session (MiniSessions)'
        })
        vim.keymap.set('n', '<leader>qq', function()
            require('mini.sessions').write()
        end, {
            desc = 'Save session (MiniSessions)'
        })
        vim.keymap.set('n', '<leader>/', function()
            require('mini.fuzzy').fuzzy_search()
        end, {
            desc = 'Fuzzy search (MiniFuzzy)'
        })
        vim.keymap.set('n', '<leader>cc', function()
            require('mini.comment').toggle_lines()
        end, {
            desc = 'Toggle comment (MiniComment)'
        })
        vim.keymap.set('n', '<leader>tt', function()
            require('mini.trailspace').trim()
        end, {
            desc = 'Trim trailing whitespace (MiniTrailspace)'
        })

        -- Floating terminal toggle
        local float_term_win = nil
        local float_term_buf = nil
        vim.keymap.set('n', '<leader>ft', function()
            if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
                vim.api.nvim_win_close(float_term_win, true)
                float_term_win = nil
                float_term_buf = nil
            else
                float_term_buf = vim.api.nvim_create_buf(false, true)
                local width = math.floor(vim.o.columns * 0.8)
                local height = math.floor(vim.o.lines * 0.8)
                local row = math.floor((vim.o.lines - height) / 2)
                local col = math.floor((vim.o.columns - width) / 2)
                float_term_win = vim.api.nvim_open_win(float_term_buf, true, {
                    relative = 'editor',
                    width = width,
                    height = height,
                    row = row,
                    col = col,
                    style = 'minimal',
                    border = 'rounded'
                })
                vim.fn.termopen(os.getenv('SHELL') or 'sh')
                vim.cmd('startinsert')
            end
        end, {
            desc = 'Toggle floating terminal'
        })

        -- Setup mini.clue for keybinding clues
        require('mini.clue').setup({
            triggers = { -- Leader triggers
            {
                mode = 'n',
                keys = '<Leader>'
            }, {
                mode = 'x',
                keys = '<Leader>'
            }, -- File explorer
            {
                mode = 'n',
                keys = '-'
            }},
            clues = { -- MiniFiles
            {
                mode = 'n',
                keys = '-',
                desc = 'Open file explorer (MiniFiles)'
            }, -- MiniBufremove
            {
                mode = 'n',
                keys = '<leader>bb',
                desc = 'Delete buffer (MiniBufremove)'
            }, -- MiniPick
            {
                mode = 'n',
                keys = '<leader>ff',
                desc = 'Find files (MiniPick)'
            }, -- MiniSessions
            {
                mode = 'n',
                keys = '<leader>ss',
                desc = 'Select session (MiniSessions)'
            }, {
                mode = 'n',
                keys = '<leader>qq',
                desc = 'Save session (MiniSessions)'
            }, -- MiniFuzzy
            {
                mode = 'n',
                keys = '<leader>/',
                desc = 'Fuzzy search (MiniFuzzy)'
            }, -- MiniComment
            {
                mode = 'n',
                keys = '<leader>cc',
                desc = 'Toggle comment (MiniComment)'
            }, -- MiniTrailspace
            {
                mode = 'n',
                keys = '<leader>tt',
                desc = 'Trim trailing whitespace (MiniTrailspace)'
            }, -- Floating terminal
            {
                mode = 'n',
                keys = '<leader>ft',
                desc = 'Toggle floating terminal'
            } -- Add more clues as needed for other Mini modules
            },
            window = {
                delay = 200
            }
        })

        vim.cmd.colorscheme 'randomhue'
    end
}
