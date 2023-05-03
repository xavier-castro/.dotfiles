local r = require("xavier.utils.remaps")

vim.g.copilot_filetypes = { TelescopePrompt = false }

vim.g.copilot_no_tab_map = true

r.map("i", "<C-a>", "copilot#Accept()", "Accepts copilot suggestion", { script = true, expr = true, silent = true })
r.map("i", "<C-x>", "copilot#Dismiss()", "Dismisses copilot suggestion", { script = true, expr = true, silent = true })
