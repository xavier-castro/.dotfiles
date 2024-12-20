-- lua/plugins/telescope.lua
return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local fb_actions = require("telescope").extensions.file_browser.actions

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				layout_config = {
					horizontal = {
						preview_cutoff = 100,
						preview_width = 0.6,
					},
				},
				file_ignore_patterns = {
					"node_modules",
					".git/",
					"dist/",
					"build/",
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
			},
			extensions = {
				file_browser = {
					hidden = false,
					hide_parent_dir = false,
					dir_icon = "",
					dir_icon_hl = "Directory",
					git_status = true,
					mappings = {
						["i"] = {
							["<C-h>"] = telescope.extensions.file_browser.actions.toggle_hidden,
						},
						["n"] = {
							["H"] = telescope.extensions.file_browser.actions.toggle_hidden,
							["%"] = fb_actions.create, -- Add the % mapping for file creation
						},
					},
					theme = "dropdown",
					previewer = false,
					hijack_netrw = true,
					grouped = true,
					respect_gitignore = true,
					initial_mode = "normal",
					layout_config = {
						height = 0.7,
						width = 0.5,
						prompt_position = "top",
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")

		-- Keymaps
		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })

		keymap.set("n", ";;", function()
			local telescope_fb = require("telescope").extensions.file_browser.file_browser
			telescope_fb({
				path = vim.fn.expand("%:p:h"),
				select_buffer = true,
				respect_gitignore = false,
			})
		end, { desc = "Browse files from current buffer directory" })
	end,
}
