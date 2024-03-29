if vim.g.vscode then
else
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
					q = actions.close,
				},
				i = {
					["<C-c>"] = actions.close,
				},
			},
		},
		extensions = {
			["ui-select"] = {
				(require("telescope.themes")).get_dropdown({}),
			},
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
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
						N = fb_actions.create,
						h = fb_actions.goto_parent_dir,
						M = fb_actions.move,
						["/"] = function()
							vim.cmd("startinsert")
						end,
					},
				},
			},
		},
	})
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("find_pickers")
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("ui-select")
	require("telescope").load_extension("harpoon")
	require("telescope").load_extension("git_worktree")

	vim.keymap.set("n", ";F", "<cmd>Telescope find_pickers<cr>", {})
	vim.keymap.set("n", "<leader>cs", "<cmd>Telescope colorscheme<cr>", {})
	vim.keymap.set("n", "<c-p>", builtin.git_files, {})
	vim.keymap.set("n", ";o", builtin.oldfiles, {})
	vim.keymap.set("n", ";f", "<Cmd>Telescope fd hidden=true no_ignore=true<Cr>", {})
	vim.keymap.set("n", ";r", function()
		builtin.registers({
			previewer = true,
		})
	end)
	vim.keymap.set("n", ";g", function()
		builtin.live_grep({
			search_dirs = {
				vim.fn.expand("%:p:h"),
			},
		})
	end)
	-- Was interfering with opening snippets
	-- vim.keymap.set("n", ";s", function()
	-- 	builtin.spell_suggest({
	-- 		attach_mappings = function(_, map)
	-- 			map("i", "<CR>", actions.select_default)
	-- 			return true
	-- 		end,
	-- 	})
	-- end)
	--
	-- Primeagen's worktree telescope functions
	vim.keymap.set("n", ";gwt", "<cmd>:lua require('telescope').extensions.git_worktree.git_worktrees()")
	vim.keymap.set("n", ";cgwt", "<cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree()")

	vim.keymap.set("n", ";c", function()
		builtin.commands({
			previewer = true,
		})
	end)
	vim.keymap.set("n", ";b", function()
		builtin.buffers({
			sort_lastused = true,
		})
	end)
	vim.keymap.set("n", ";h", function()
		builtin.help_tags({
			previewer = true,
		})
	end)
	vim.keymap.set("n", ";j", function()
		builtin.jumplist()
	end)
	vim.keymap.set("n", ";t", "<cmd>TodoTelescope keywords=TODO,FIX<cr>", {})
	vim.keymap.set("n", ";m", "<cmd>Telescope marks<cr>", {})
	vim.keymap.set("n", "<M-e>", "<cmd>Telescope harpoon marks<cr>", {})
	vim.keymap.set("n", ";<Space>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", {})
	vim.keymap.set("n", ";;", function()
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
end
