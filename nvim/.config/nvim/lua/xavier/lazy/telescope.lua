return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"folke/todo-comments.nvim",
		"andrew-george/telescope-themes",
	},

	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-o>"] = require("telescope.actions").select_horizontal,
						["<C-v>"] = require("telescope.actions").select_vertical,
					},
				},
			},

			extensions = {
				fzf = {},
				themes = {
					-- (boolean) -> show/hide previewer window
					enable_previewer = true,
					-- (boolean) -> enable/disable live preview
					enable_live_preview = true,
					persist = {
						enabled = true,
						path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
					},
				},
			},
		})

		-- Load Extensions here
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>pf", function()
			builtin.find_files({ hidden = true })
		end, {})

		vim.keymap.set("n", "<leader>po", function()
			builtin.oldfiles()
		end, {})

		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)

		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)

		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		vim.keymap.set(
			"n",
			"<leader>ths",
			":Telescope themes<CR>",
			{ noremap = true, silent = true, desc = "Theme Switcher" }
		)
	end,
}
