return {
    {
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "rafamadriz/friendly-snippets",
        },

        config = function()
            local lsp_zero = require("lsp-zero")
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<M-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<M-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-f>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<Tab>"] = nil,
                    ["<S-Tab>"] = nil,
                    ["<C-j>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
                                ""
                            )
                        else
                            local copilot_keys = vim.fn["copilot#Accept"]()
                            if copilot_keys ~= "" then
                                vim.api.nvim_feedkeys(copilot_keys, "i", true)
                            else
                                fallback()
                            end
                        end
                    end,

                    ["<C-k>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require("luasnip").jumpable(-1) then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
                                ""
                            )
                        else
                            fallback()
                        end
                    end,
                }),
                sources = {
                    { name = "nvim_lsp_signature_help" },
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "buffer" },
                },
                formatting = lsp_zero.cmp_format(),
            })
        end,
    },
}
