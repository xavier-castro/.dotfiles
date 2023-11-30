-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	tag = "0.1.4",
	dependencies = {
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"wesleimp/telescope-windowizer.nvim",
		"nvim-telescope/telescope-frecency.nvim",
		"ThePrimeagen/git-worktree.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"keyvchan/telescope-find-pickers.nvim",
		{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
	},
	config = function()
		local builtin = require("telescope.builtin")
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local fb_actions = require("telescope").extensions.file_browser.actions

		vim.keymap.set("n", ";;", builtin.resume, { desc = "Resume last telescope" })
		vim.keymap.set("n", "\\\\", builtin.buffers, { desc = "Buffers" })
		-- Current Buffer Fuzzy Find
		vim.keymap.set("n", "<leader>pp", builtin.current_buffer_fuzzy_find, { desc = "Current Buffer Fuzzy Find" })
		-- Live Grep
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Live Grep" })
		-- Commands
		vim.keymap.set("n", "<leader>po", builtin.oldfiles, { desc = "Commands" })
		-- Find Files
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
		-- Git Files
		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git Files" })
		-- Help Tags
		vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Help Tags" })
		-- Marks
		vim.keymap.set("n", "<leader>pm", builtin.marks, { desc = "Marks" })
		-- Colorscheme
		vim.keymap.set("n", "<leader>pc", builtin.colorscheme, { desc = "Colorscheme" })
		-- Tags
		vim.keymap.set("n", "<leader>pt", builtin.tags, { desc = "Tags" })
		-- Registers
		vim.keymap.set("n", "<leader>pr", builtin.registers, { desc = "Registers" })
		-- Jumplists
		vim.keymap.set("n", "<leader>pj", builtin.jumplist, { desc = "Jumplist" })
		vim.keymap.set("n", "<leader><leader>", "<Cmd>Telescope frecency workspace=CWD<CR>", { desc = "Frecency" })
		vim.keymap.set("n", "<leader>pw", function()
			builtin.live_grep()
		end, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>pW", function()
			builtin.live_grep({
				additional_args = function(args)
					return vim.list_extend(args, { "--hidden", "--no-ignore" })
				end,
			})
		end, { desc = "Live grep (hidden)" })

		vim.keymap.set("n", "<leader>pg", function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end, { desc = "Live Grep Args" })

		vim.keymap.set("n", "<leader>pu", function()
			require("telescope").extensions.undo.undo()
		end, { desc = "Undo Tree" })

		-- File Browser
		vim.keymap.set("n", "<leader>pf", function()
			local function telescope_buffer_dir()
				return vim.fn.expand("%:p:h")
			end
			require("telescope").extensions.file_browser.file_browser({
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
		end, { desc = "File Browser" })

		-- Git Worktree
		vim.keymap.set("n", "<leader>pw", "<Cmd>Telescope git_worktree<CR>", { desc = "Git Worktree" })
		vim.keymap.set(
			"n",
			"<leader>pn",
			"<Cmd>Telescope git_worktree create_git_worktree<CR>",
			{ desc = "Git Worktree" }
		)

		-- Telescope Settings
		telescope.setup({
			defaults = {
				git_worktrees = vim.g.git_worktrees,
				path_display = { "shorten" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				n = {
					["q"] = actions.close,
					["ss"] = actions.select_horizontal, -- default: ["<C-x>"]
					["sv"] = actions.select_vertical, -- default: ["<C-v>"]
					["st"] = actions.select_tab, -- default: ["<C-t>"]
					-- ["Q"] = actions.send_selected_to_qflist + actions.open_qflist, -- default: ["<M-q>"]
				},
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
			file_ignore_patterns = {
				"node_modules",
				"vendor",
				"dist",
				"build",
				"target",
				"yarn.lock",
				"package-lock.json",
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				frecency = {
					show_scores = false,
					show_unindexed = true,
					ignore_patterns = { "*.git/*", "*/tmp/*", "node_modules", "lazy-lock.json" },
					disable_devicons = false,
					workspaces = {
						["dev"] = "/Users/xc/Developer",
					},
				},
				file_browser = {
					theme = "dropdown",
					hidden = true,
					hijack_netrw = true,
					mappings = {
						i = {
							["<C-w>"] = function()
								vim.cmd("normal vbd")
							end,
						},
						n = {
							["%"] = fb_actions.create,
							["-"] = fb_actions.goto_parent_dir,
							M = fb_actions.move,
							["/"] = function()
								vim.cmd("startinsert")
							end,
						},
					},
				},
				["ui-select"] = {
					(require("telescope.themes")).get_dropdown({}),
				},
			},
			pickers = {
				buffers = {
					show_all_buffers = true,
					initial_mode = "normal",
					sort_lastused = true,
					mappings = {
						n = {
							["<c-d>"] = actions.delete_buffer,
						},
					},
				},
			},
		})
		-- Extensions
		telescope.load_extension("fzf")
		telescope.load_extension("windowizer")
		telescope.load_extension("frecency")
		telescope.load_extension("git_worktree")
		telescope.load_extension("find_pickers")
		telescope.load_extension("file_browser")
		telescope.load_extension("ui-select")
		telescope.load_extension("undo")
		telescope.load_extension("live_grep_args")
	end,
}
