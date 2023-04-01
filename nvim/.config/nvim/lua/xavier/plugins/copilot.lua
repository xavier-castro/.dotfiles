return {{
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            panel = {
                auto_refresh = true,
                layout = {
                    position = "bottom", -- | top | left | right
                    ratio = 0.2
                }
            },
            suggestion = {
                auto_trigger = false,
                keymap = {
                    accept = "<M-r>",
                    dismiss = "<M-e>"
                }
            }
        })
        vim.keymap.set("n", "<leader>cpt", "<cmd>Copilot suggestion toggle_auto_triggler<CR>", { silent = true })
    end
}}
