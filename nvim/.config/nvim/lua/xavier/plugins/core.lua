require("xavier.config").init()

return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opt = function()
            require("copilot").setup({
                panel = { auto_refresh = true },
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = "<M-r>",
                        dismiss = "<M-e>",
                    },
                }
            })
        end
    },
}
