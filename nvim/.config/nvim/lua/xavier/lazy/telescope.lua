return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"andrew-george/telescope-themes",
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local trouble = require("trouble")
		local builtin = require("telescope.builtin")
		-- create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function()
				trouble.toggle("quickfix")
			end,
		})

		-- NOTE: Telescope Extensions
		telescope.load_extension("fzf")
		telescope.load_extension("themes") -- Telescope themes by Andrew George

		require("telescope").setup({

			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move test to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
					},
				},
			},
			-- config for telescope themes
			extensions = {
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

		vim.keymap.set("n", "<leader>pf", function()
			require("telescope.builtin").find_files({ hidden = true, layout_config = { prompt_position = "top" } })
		end, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "\\\\", builtin.buffers, {})
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>po", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
		vim.keymap.set(
			"n",
			"<leader>ths",
			":Telescope themes<CR>",
			{ noremap = true, silent = true, desc = "Theme Switcher" }
		)
	end,
}
