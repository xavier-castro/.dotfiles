return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-p>",
				},
				layout = {
					position = "bottom", -- | top | left | right | horizontal | vertical
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
				hide_during_completion = false,
				debounce = 25,
				keymap = {
					accept = "<M-y>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>", -- How to trigger
					prev = "<M-[>",
					dismiss = "<M-e>",
				},
			},
		})
	end,
}
