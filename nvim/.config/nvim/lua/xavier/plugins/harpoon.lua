return {
	{
		"theprimeagen/harpoon",
		event = "VeryLazy",
		keys = {
			{
				";e",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Harpoon",
			},
		},
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")
			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<M-h>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<M-j>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<M-k>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<M-l>", function()
				ui.nav_file(4)
			end)
		end,
	},
}