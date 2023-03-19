return {
    {
        "jose-elias-alvarez/typescript.nvim",
        config = function()
            require("typescript").setup({})
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local lsp = require("lsp-zero")
            local null_ls = require("null-ls")
            ---@diagnostic disable-next-line: lowercase-global
            null_opts = lsp.build_options("null-ls", {})

            null_ls.setup({
                on_attach = function(client, bufnr)
                    null_opts.on_attach(client, bufnr)

                    --- your code goes here...
                end,
                sources = {
                    require("typescript.extensions.null-ls.code-actions"),
                },
            })

            require("mason-null-ls").setup({
                ensure_installed = nil,
                automatic_installation = true,
                automatic_setup = false,
            })
        end,
        vim.api.nvim_create_user_command("DisableLspFormatting", function()
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
        end, { nargs = 0 }),
    },
}
