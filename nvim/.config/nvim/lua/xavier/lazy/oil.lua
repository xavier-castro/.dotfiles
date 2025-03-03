return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	opts = {
		default_file_explorer = true,
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name, _)
				return name == "node_modules" or name == ".git"
			end,
		},
		float = {
			max_width = 235,
			max_height = 65,
		},
		keymaps = {
			["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
			["<C-x>"] = {
				"actions.select",
				opts = { horizontal = true },
				desc = "Open the entry in a horizontal split",
			},
			["<c-c>"] = false,
			["q"] = "actions.close",
		},
	},
	-- Oil
	vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Oil", silent = true }),
}
