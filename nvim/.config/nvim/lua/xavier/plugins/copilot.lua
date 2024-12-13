return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = {
				TelescopePrompt = false,
			}
			vim.keymap.set({ "i", "n" }, "<M-p>", ":Copilot panel<cr>")
			vim.keymap.set("i", "<C-a>", 'copilot#Accept("<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			vim.g.copilot_no_tab_map = true
		end,

		"zbirenbaum/copilot.lua",
		config = function()
			local copilot = require("copilot")
			copilot.setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = false,
					},
				},
				filetypes = {
					markdown = true,
					help = true,
				},
			})
		end,
	},
}
