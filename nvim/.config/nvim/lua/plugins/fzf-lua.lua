return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>fP",
            function()
                require("fzf-lua").files({
                    cwd = require("lazy.core.config").options.root,
                })
            end,
            desc = "Find Plugin File",
        },
        {
            ";f",
            function()
                require("fzf-lua").files({
                    fd_opts = "--color=never --type f --hidden --follow --exclude .git",
                })
            end,
            desc = "Lists files in your current working directory, respects .gitignore",
        },
        {
            ";r",
            function()
                require("fzf-lua").live_grep({
                    rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden",
                })
            end,
            desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
        },
        {
            "\\\\",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "Lists open buffers",
        },
        {
            ";t",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
        },
        {
            ";;",
            function()
                require("fzf-lua").resume()
            end,
            desc = "Resume the previous fzf-lua picker",
        },
        {
            ";e",
            function()
                require("fzf-lua").diagnostics_workspace()
            end,
            desc = "Lists Diagnostics for all open buffers or a specific buffer",
        },
        {
            ";s",
            function()
                require("fzf-lua").treesitter()
            end,
            desc = "Lists Function names, variables, from Treesitter",
        },
        {
            ";c",
            function()
                require("fzf-lua").lsp_incoming_calls()
            end,
            desc = "Lists LSP incoming calls for word under the cursor",
        },
        {
            "sf",
            function()
                local current_dir = vim.fn.expand("%:p:h")
                require("fzf-lua").files({
                    cwd = current_dir,
                    fd_opts = "--color=never --type f --hidden --follow",
                })
            end,
            desc = "Open File Browser with the path of the current buffer",
        },
    },
    config = function()
        local fzf = require("fzf-lua")
        
        fzf.setup({
            winopts = {
                height = 0.85,
                width = 0.80,
                preview = {
                    horizontal = "right:50%",
                    layout = "horizontal",
                },
            },
            keymap = {
                fzf = {
                    ["ctrl-u"] = "half-page-up",
                    ["ctrl-d"] = "half-page-down",
                    ["ctrl-a"] = "beginning-of-line",
                    ["ctrl-e"] = "end-of-line",
                    ["alt-a"] = "toggle-all"
                },
            },
            files = {
                previewer = "builtin",
            },
            grep = {
                previewer = "builtin",
            },
            diagnostics = {
                previewer = "builtin",
            },
        })
    end,
}
