return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
					auto_refresh = true,
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.2,
					},
				},
				suggestion = {
					enabled = false,
					auto_trigger = false,
					keymap = {
						accept = "<M-r>",
						dismiss = "<M-e>",
					},
				},
			})
			vim.keymap.set(
				"n",
				"<leader>cpt",
				"<cmd>Copilot suggestion toggle_auto_trigger<CR>:lua require('notify')('Copilot Toggled')<cr>"
			)
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
