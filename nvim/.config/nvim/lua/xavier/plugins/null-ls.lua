return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            { "jose-elias-alvarez/typescript.nvim" },
        },
        config = function()
            local null_ls = require("null-ls")
            local b = null_ls.builtins

            null_ls.setup({
                sources = {
                    require("typescript.extensions.null-ls.code-actions"),
                    b.code_actions.refactoring,
                    b.completion.luasnip,
                    b.formatting.stylua,
                    b.formatting.prettierd,
                    b.formatting.prismaFmt,
                    b.formatting.rustywind,
                    b.formatting.deno_fmt.with({
                        filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
                    }),
                },
            })

            -- Format on Save
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            require("null-ls").setup({
                -- you can reuse a shared lspconfig on_attach callback here
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                vim.lsp.buf.format({bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
