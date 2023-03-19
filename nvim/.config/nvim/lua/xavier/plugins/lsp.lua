return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "dev-v2",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },           -- Required
            { "williamboman/mason.nvim" },         -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },                -- Required
            { "hrsh7th/cmp-nvim-lsp" },            -- Required
            { "L3MON4D3/LuaSnip" },                -- Required
            -- XC Extras
            { "jose-elias-alvarez/null-ls.nvim" },
            { "jay-babu/mason-null-ls.nvim" },
            { "jose-elias-alvarez/typescript.nvim" }, { "onsails/lspkind.nvim" }
        },
        config = function()
            -- MARK: Initial setup
            local lsp = require("lsp-zero").preset("minimal")

            -- MARK: This is where you add your default keybinds
            -- lsp.on_attach(function(client, bufnr)
            --     lsp.default_keymaps({ buffer = bufnr })
            -- end)

            -- MARK: This is where you configure your LSPs
            -- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            -- require('lspconfig').tsserver.setup({})
            -- require('lspconfig').tailwindcss.setup({})
            -- require('lspconfig').remark_ls.setup({})

            -- MARK: for-loop auto setting up LSP
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- Replace these with whatever servers you want to install
                    "remark_ls", "tsserver", "lua_ls", "tailwindcss"
                }
            })
            local lsp_capabilities =
                require("cmp_nvim_lsp").default_capabilities()
            local lsp_attach = function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end
            local lspconfig = require("lspconfig")
            local get_servers = require("mason-lspconfig").get_installed_servers

            for _, server_name in ipairs(get_servers()) do
                lspconfig[server_name].setup({
                    on_attach = lsp_attach,
                    capabilities = lsp_capabilities
                })
            end

            -- MARK: Completion configuration
            local cmp = require("cmp")
            local cmp_action = require("lsp-zero").cmp_action()
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                sources = {
                    { name = "path" }, { name = "nvim_lsp" }, { name = "nvim_lua" },
                    { name = "luasnip" }, { name = "buffer", keyword_length = 3 }
                },
                mapping = {
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward()
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol",      -- show only symbol annotations
                        maxwidth = 50,        -- prevent the popup from showing more than provided characters
                        ellipsis_char =
                        "..."                 -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                    })
                }
            })

            -- MARK: Final thing to get it all going
            lsp.setup()

            -- MARK: AFTER `lsp.setup()` has been called you can now run null-ls
            local null_ls = require("null-ls")
            local bf = null_ls.builtins.formatting
            null_ls.setup({
                on_attach = function(client, bufnr)
                    local format_cmd = function(input)
                        vim.lsp.buf.format({
                            id = client.id,
                            timeout_ms = 5000,
                            async = input.bang
                        })
                    end

                    local bufcmd = vim.api.nvim_buf_create_user_command
                    bufcmd(bufnr, "NullFormat", format_cmd, {
                        bang = true,
                        range = true,
                        desc = "Format using null-ls"
                    })

                    vim.keymap.set("n", "<leader>n", "<cmd>NullFormat!<cr>",
                        { buffer = bufnr })
                end,
                sources = {
                    --- Replace these with the tools you have installed
                    bf.prettier, bf.prettierd, bf.shfmt, bf.stylua, bf.prettier,
                    require("typescript.extensions.null-ls.code-actions")
                }
            })

            -- See mason-null-ls.nvim's documentation for more details:
            -- https://github.com/jay-babu/mason-null-ls.nvim#setup
            require("mason-null-ls").setup({
                ensure_installed = nil,
                automatic_installation = true, -- You can still set this to `true`
                automatic_setup = true
            })

            -- Required when `automatic_setup` is true
            require("mason-null-ls").setup_handlers()
        end
    }
}
