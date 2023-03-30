return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {
                -- Optional
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" }, -- Required
            { "onsails/lspkind.nvim" },
        },
        config = function()
            local lsp = require("lsp-zero").preset({
                manage_nvim_cmp = {
                    set_sources = "recommended",
                    set_basic_mappings = true,
                    set_extra_mappings = false,
                    use_luasnip = true,
                    set_format = true,
                    documentation_window = true,
                },
            })
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({
                    buffer = bufnr,
                })
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "<leader>nls", "<cmd>NullLsInfo<cr>", opts)
                vim.keymap.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover()
                end, opts)
                vim.keymap.set("n", "<leader>vws", function()
                    vim.lsp.buf.workspace_symbol()
                end, opts)
                vim.keymap.set("n", "<leader>vd", function()
                    vim.diagnostic.open_float()
                end, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_next()
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_prev()
                end, opts)
                vim.keymap.set("n", "<leader>vca", function()
                    vim.lsp.buf.code_action()
                end, opts)
                vim.keymap.set("n", "<leader>vrr", function()
                    vim.lsp.buf.references()
                end, opts)
                vim.keymap.set("n", "<leader>vrn", function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set("i", "<C-h>", function()
                    vim.lsp.buf.signature_help()
                end, opts)
                -- vim.keymap.set("n", "<M-.>", function()
                --     vim.lsp.buf.code_action()
                -- end, opts)
                -- vim.keymap.set("i", "<M-.>", function()
                --     vim.lsp.buf.code_action()
                -- end, opts)
                vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
                vim.keymap.set("n", "gl", "<Cmd>Lspsaga show_diagnostic<CR>", opts)
                vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
                vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
                -- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
                vim.keymap.set("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
                vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
                vim.keymap.set("n", "<M-d>", "<cmd>Lspsaga term_toggle<cr>", opts)
                -- code action
                local codeaction = require("lspsaga.codeaction")
                vim.keymap.set("n", "<M-.>", function()
                    codeaction:code_action()
                end, { silent = true })
                vim.keymap.set("v", "<M-.>", function()
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
                    codeaction:range_code_action()
                end, { silent = true })
            end)

            -- (Optional) Configure lua language server for neovim
            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
            lsp.setup()

            -- (Optional) Configure nvim-cmp
            local cmp = require("cmp")
            local cmp_action = require("lsp-zero").cmp_action()
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                mapping = {
                    ["<M-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<M-b>"] = cmp_action.luasnip_jump_backward(),
                    ["<Tab>"] = cmp_action.luasnip_supertab(),
                    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol", -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters
                        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                    }),
                },
            })
        end,
    },
}
