return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'dev-v2',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            { 'onsails/lspkind.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        },
        config = function()
            -- MARK: Initial setup
            local lsp = require('lsp-zero').preset('minimal')

            -- MARK: This is where you add your default keybinds
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            -- MARK: This is where you configure your LSPs
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            require('lspconfig').tsserver.setup({})
            require('lspconfig').tailwindcss.setup({})
            require('lspconfig').remark_ls.setup({})

            -- MARK: Completion configuration
            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'buffer',  keyword_length = 3 },
                },
                mapping = {
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                },
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = require('lspkind').cmp_format({
                        mode = 'symbol',       -- show only symbol annotations
                        maxwidth = 50,         -- prevent the popup from showing more than provided characters
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                    })
                }
            })

            -- MARK: Final thing to get it all going
            lsp.setup()
        end
    }
}
