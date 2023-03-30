return {
	{
		"glepnir/dashboard-nvim",
		config = function()
			local db = require("dashboard")
			db.setup({
				theme = "hyper",
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{ desc = " Update", group = "@property", action = "Lazy update", key = "u" },
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Recent",
							group = "Label",
							action = "Telescope oldfiles",
							key = "o",
						},
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						-- {
						--     desc = " Apps",
						--     group = "DiagnosticHint",
						--     action = "Telescope app",
						--     key = "a",
						-- },
						{
							desc = " dotfiles",
							group = "Number",
							action = "SessionLoad dotfiles",
							key = "d",
						},
					},
				},
			})
		end,
	},
	{
		"glepnir/dbsession.nvim",
		cmd = { "SessionSave", "SessionDelete", "SessionLoad" },
		opts = { --config --}
		},
	},
}
