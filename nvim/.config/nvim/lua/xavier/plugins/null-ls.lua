return {
    {
        "jose-elias-alvarez/typescript.nvim",
        config = function() require("typescript").setup({}) end
    }, {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local lsp = require("lsp-zero")
            local null_ls = require("null-ls")
            local lsp_formatting = function(bufnr)
                vim.lsp.buf.format({
                    filter = function(client)
                        return client.name == "null-ls"
                    end,
                    bufnr = bufnr
                })
            end

            ---@diagnostic disable-next-line: lowercase-global
            null_opts = lsp.build_options("null-ls", {})
            require("mason").setup()
            require("mason-null-ls").setup({
                ensure_installed = {
                    -- Opt to list sources here, when available in mason.
                },
                automatic_installation = true,
                automatic_setup = true -- Recommended, but optional
            })
            null_ls.setup({
                sources = {
                    -- Anything not supported by mason.
                    require("typescript.extensions.null-ls.code-actions")
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                lsp_formatting(bufnr)
                            end
                        })
                    end
                end
            })
            require("mason-null-ls").setup_handlers() -- If `automatic_setup` is true.
        end,
        vim.api.nvim_create_user_command("DisableLspFormatting", function()
            vim.api.nvim_clear_autocmds({group = augroup, buffer = 0})
        end, {nargs = 0})
    }
}
