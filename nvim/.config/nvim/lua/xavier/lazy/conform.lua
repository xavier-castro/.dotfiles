return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {

                -- Use black for Python
                python = { "black" },

                -- Use prettier for web development and related files
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                less = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                vue = { "prettier" },
                svelte = { "prettier" },

                -- Use recommended formatters for other common languages
                lua = { "stylua" },
                rust = { "rustfmt" },
                go = { "gofmt", "goimports" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                java = { "google_java_format" },
                php = { "php_cs_fixer" },
                ruby = { "rubocop" },
                shell = { "shfmt" },
                bash = { "shfmt" },
                sql = { "sql_formatter" },
                terraform = { "terraform_fmt" },
            },
        })

        -- Format entire buffer
        vim.keymap.set("n", "<leader>lf", function()
            require("conform").format({ async = true })
        end, { desc = "Format document" })

        -- Format visual selection
        vim.keymap.set("v", "<leader>lf", function()
            require("conform").format({
                async = true,
                range = {
                    start = vim.fn.getpos("'<"),
                    ["end"] = vim.fn.getpos("'>"),
                }
            })
        end, { desc = "Format range" })
    end
}
