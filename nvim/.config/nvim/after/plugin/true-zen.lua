local truezen = require("true-zen")
truezen.setup({
	integrations = {},
	modes = {
		ataraxis = {
			quit_untoggles = true,
			minimum_writing_area = { -- minimum size of main window
				width = 80,
			},
			padding = {
				-- padding windows
				left = 5,
				right = 5,
				top = 0,
				bottom = 0,
			},
		},
	},
})