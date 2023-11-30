-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	tag = "0.1.4",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"wesleimp/telescope-windowizer.nvim",
		"nvim-telescope/telescope-frecency.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		local telescope = require("telescope")
		vim.keymap.set("n", ";;", builtin.pickers, { desc = "Telescope cached picker" })
		vim.keymap.set("n", "\\\\", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>po", builtin.oldfiles, { desc = "Commands" })
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git Files" })
		vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Help Tags" })
		vim.keymap.set("n", "<leader><leader>", "<Cmd>Telescope frecency workspace=CWD<CR>", { desc = "Frecency" })

		-- Telescope Settings
		telescope.setup({
			defaults = {
				path_display = { "shorten" },
				sorting_strategy = "ascending",
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--ignore-file",
					".gitignore",
				},
			},
			extensions = {
				frecency = {
					show_scores = false,
					show_unindexed = true,
					ignore_patterns = { "*.git/*", "*/tmp/*", "node_modules", "lazy-lock.json" },
					disable_devicons = false,
					workspaces = {
						["dev"] = "/Users/xc/Developer",
					},
				},
			},
		})
		-- Extensions
		telescope.load_extension("windowizer")
		telescope.load_extension("frecency")
	end,
}
