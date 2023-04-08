return {
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")
			local function telescope_buffer_dir()
				return vim.fn.expand("%:p:h")
			end

			local fb_actions = require("telescope").extensions.file_browser.actions

			telescope.setup({
				defaults = {
					mappings = {
						n = {
							["q"] = actions.close,
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),

						-- pseudo code / specification for writing custom displays, like the one
						-- for "codeactions"
						-- specific_opts = {
						--   [kind] = {
						--     make_indexed = function(items) -> indexed_items, width,
						--     make_displayer = function(widths) -> displayer
						--     make_display = function(displayer) -> function(e)
						--     make_ordinal = function(e) -> string
						--   },
						--   -- for example to disable the custom builtin "codeactions" display
						--      do the following
						--   codeactions = false,
						-- }
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					file_browser = {
						theme = "dropdown",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						mappings = {
							-- your custom insert mode mappings
							["i"] = {
								["<C-w>"] = function()
									vim.cmd("normal vbd")
								end,
							},
							["n"] = {
								-- your custom normal mode mappings
								["N"] = fb_actions.create,
								["h"] = fb_actions.goto_parent_dir,
								["M"] = fb_actions.move,
								["/"] = function()
									vim.cmd("startinsert")
								end,
							},
						},
					},
				},
			})
			-- Load extensions after setup so they work
			telescope.load_extension("file_browser")
			telescope.load_extension("fzf")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("harpoon")

			-- Keybinds
			vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
			vim.keymap.set("n", "<leader>cs", "<cmd>Telescope colorscheme<cr>", {})
			vim.keymap.set("n", "<C-p>", builtin.git_files, {})
			vim.keymap.set("n", "<leader>po", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({
					search = vim.fn.input("Grep > "),
				})
			end)
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader><leader>", function()
				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = telescope_buffer_dir(),
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					previewer = false,
					initial_mode = "normal",
					layout_config = {
						height = 40,
					},
				})
			end)
		end,
	},
}
