local searcher = "xavier" --- "telescope" | "Xavier"
if searcher == "xavier" then
	vim.opt.grepprg = "rg --vimgrep --smart-case"
	vim.keymap.set("n", "<leader>/", function()
		local pattern = vim.fn.input("rg: ")
		if pattern ~= "" then
			vim.cmd('silent grep! "' .. pattern .. '"')
			vim.cmd("copen")
		end
	end, { desc = "xavier: Live grep" })

	function Fd(file_pattern, _)
		-- if first char is * then fuzzy search
		if file_pattern:sub(1, 1) == "*" then
			file_pattern = file_pattern:gsub(".", ".*%0") .. ".*"
		end
		local cmd = 'fd  --color=never --full-path --type file --hidden --exclude=".git" "' .. file_pattern .. '"'
		local result = vim.fn.systemlist(cmd)
		return result
	end

	vim.opt.findfunc = "v:lua.Fd"
	vim.keymap.set("n", "<C-p>", ":find ", { desc = "xavier: Project Files" })
	return {
		{
			"nvim-telescope/telescope.nvim",
			priority = 1000,
			lazy = false,
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
				"nvim-telescope/telescope-ui-select.nvim",
				"nvim-telescope/telescope-file-browser.nvim",
			},
			opts = {},
			keys = {
				{
					"<leader>fP",
					function()
						require("telescope.builtin").find_files({
							cwd = require("lazy.core.config").options.root,
						})
					end,
					desc = "Find Plugin File",
				},
				{
					";f",
					function()
						local builtin = require("telescope.builtin")
						builtin.find_files({
							no_ignore = false,
							hidden = true,
						})
					end,
					desc = "Lists files in your current working directory, respects .gitignore",
				},
				{
					";r",
					function()
						local builtin = require("telescope.builtin")
						builtin.live_grep({
							additional_args = { "--hidden" },
						})
					end,
					desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
				},
				{
					"\\\\",
					function()
						local builtin = require("telescope.builtin")
						builtin.buffers()
					end,
					desc = "Lists open buffers",
				},
				{
					";t",
					function()
						local builtin = require("telescope.builtin")
						builtin.help_tags()
					end,
					desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
				},
				{
					";;",
					function()
						local builtin = require("telescope.builtin")
						builtin.resume()
					end,
					desc = "Resume the previous telescope picker",
				},
				{
					";e",
					function()
						local builtin = require("telescope.builtin")
						builtin.diagnostics()
					end,
					desc = "Lists Diagnostics for all open buffers or a specific buffer",
				},
				{
					";s",
					function()
						local builtin = require("telescope.builtin")
						builtin.treesitter()
					end,
					desc = "Lists Function names, variables, from Treesitter",
				},
				{
					";c",
					function()
						local builtin = require("telescope.builtin")
						builtin.lsp_incoming_calls()
					end,
					desc = "Lists LSP incoming calls for word under the cursor",
				},
				{
					"sf",
					function()
						local telescope = require("telescope")

						local function telescope_buffer_dir()
							return vim.fn.expand("%:p:h")
						end

						telescope.extensions.file_browser.file_browser({
							path = "%:p:h",
							cwd = telescope_buffer_dir(),
							respect_gitignore = false,
							hidden = true,
							grouped = true,
							previewer = false,
							initial_mode = "normal",
							layout_config = { height = 40 },
						})
					end,
					desc = "Open File Browser with the path of the current buffer",
				},
			},
			config = function()
				local default_theme = "dropdown"
				require("telescope").setup({
					pickers = {
						find_files = {
							theme = default_theme,
							previewer = false,
						},
						git_files = {
							theme = default_theme,
							previewer = false,
						},
						builtin = {
							theme = default_theme,
							previewer = false,
						},
						current_buffer_fuzzy_find = {
							previewer = false,
						},
					},
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_ivy(),
						},
					},
				})
				local utils = require("telescope.utils")
				local builtin = require("telescope.builtin")
				local project_files = function()
					local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
					if ret == 0 then
						builtin.git_files()
					else
						builtin.find_files()
					end
				end
				vim.keymap.set("n", "<C-p>", project_files, { desc = "Project Files" })
				vim.keymap.set("n", "<leader>tj", builtin.builtin, { desc = "Telescope builtins" })
				vim.keymap.set("n", "<leader>tf", builtin.find_files, { desc = "Telescope find files" })
				vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
				vim.keymap.set("n", "<leader>th", builtin.help_tags, { desc = "Telescope help tags" })
				vim.keymap.set("n", "<leader>c", function()
					builtin.git_files({ cwd = "~/.config/nvim/" })
				end, { desc = "Open nvim init.lua" })

				require("telescope").load_extension("fzf")
				require("telescope").load_extension("ui-select")
				require("telescope").load_extension("file_browser")
			end,
		},
	}
end
