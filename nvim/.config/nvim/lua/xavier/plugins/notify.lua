return {
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			vim.notify = require("notify")
			notify.setup({
				stages = "fade_in_slide_out",
				timeout = 4000,
				background_colour = "#1e222a",
				icons = {
					ERROR = " ",
					WARN = " ",
					INFO = " ",
					DEBUG = " ",
					TRACE = " ",
				},
			})
		end,
	},
}
