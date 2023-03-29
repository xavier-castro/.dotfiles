return {{
    "VonHeikemen/lsp-zero.nvim",
    branch = "dev-v2",
    dependencies = { -- LSP Support
    {"neovim/nvim-lspconfig"}, -- Required
    {"williamboman/mason.nvim"}, -- Optional
    {"williamboman/mason-lspconfig.nvim"}, -- Optional
    -- Autocompletion
    {"hrsh7th/nvim-cmp"}, -- Required
    {"hrsh7th/cmp-nvim-lsp"}, -- Required
    {"L3MON4D3/LuaSnip"}, -- Required
    -- XC Extras
    {"jose-elias-alvarez/null-ls.nvim"}, {"jay-babu/mason-null-ls.nvim"}, {"jose-elias-alvarez/typescript.nvim"},
    {"onsails/lspkind.nvim"}},
    config = function()
        -- MARK: Initial setup
        local lsp = require("lsp-zero").preset("minimal")

        -- MARK: for-loop auto setting up LSP
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { -- Replace these with whatever servers you want to install
            "prismals", "tsserver", "lua_ls", "tailwindcss"}
        })
        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lsp_attach = function(client, bufnr)
            lsp.default_keymaps({
                buffer = bufnr
            })
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
            vim.keymap.set("v", "<leader>vca", function()
                vim.lsp.buf.code_action()
            end, opts)
            vim.keymap.set("n", "<M-.>", function()
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
        -- Helper Functions
        local lspkind = require("lspkind")
        local function formatForTailwindCSS(entry, vim_item)
            if vim_item.kind == "Color" and entry.completion_item.documentation then
                local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
                if r then
                    local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
                    local group = "Tw_" .. color
                    if vim.fn.hlID(group) < 1 then
                        vim.api.nvim_set_hl(0, group, {
                            fg = "#" .. color
                        })
                    end
                    vim_item.kind = "●"
                    vim_item.kind_hl_group = group
                    return vim_item
                end
            end
            vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
            return vim_item
        end
        local cmp = require("cmp")
        local cmp_action = require("lsp-zero").cmp_action()
        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                })
            }),
            sources = {{
                name = "path"
            }, {
                name = "nvim_lsp"
            }, {
                name = "nvim_lua"
            }, {
                name = "luasnip"
            }, {
                name = "buffer",
                keyword_length = 3
            }},
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    before = function(entry, vim_item)
                        vim_item = formatForTailwindCSS(entry, vim_item)
                        return vim_item
                    end
                })
            }
        })

        -- MARK: Final thing to get it all going
        lsp.setup()

        -- MARK: AFTER `lsp.setup()` has been called you can now run null-ls
        local null_ls = require("null-ls")
        -- local bf = null_ls.builtins.formatting
        -- local bd = null_ls.builtins.diagnostics
        local ba = null_ls.builtins.code_actions
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

                vim.keymap.set("n", "<leader>f", "<cmd>NullFormat!<cr>", {
                    buffer = bufnr
                })
            end,
            sources = { --- Replace these with the tools you have installed
            ba.refactoring, require("typescript.extensions.null-ls.code-actions")}
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

        vim.cmd([[
          set completeopt=menuone,noinsert,noselect
          highlight! default link CmpItemKind CmpItemMenuDefault
            ]])
    end
}}
