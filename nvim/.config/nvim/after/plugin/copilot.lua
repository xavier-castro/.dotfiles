require("copilot").setup({
    panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-l>",
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<M-r>",
            next = "<M->>",
            prev = "<M-<>",
            dismiss = "<C-]>",
        },
    },
    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
    copilot_node_command = "node", -- Node version must be < 18
    server_opts_overrides = {},
})

local wk = require("which-key")

wk.register({
    c = {
        name = "+ai",
        p = { ":Copilot suggestion toggle_auto_trigger<cr>", "Toggle Auto Trigger" },
        c = { ":ChatGPT<cr>", "ChatGPT" },
        m = { ":ChatGPTActAs<cr>", "ChatGPT Act As" },
    }
}, { prefix = "<leader>" })
