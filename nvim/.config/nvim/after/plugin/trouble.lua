local wk = require("which-key")
wk.register({
    x = {
        name = "+trouble",
        q = { ":TroubleToggle quickfix<CR>", "Trouble Toggle Quickfix" },
        l = { ":TroubleToggle loclist<CR>", "Trouble Toggle Loclist" },
        t = { ":TroubleToggle<CR>", "Trouble Toggle" },
    },
}, { prefix = "<leader>" })
