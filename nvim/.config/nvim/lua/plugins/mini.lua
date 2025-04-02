return {
	"echasnovski/mini.nvim",
	config = function()
		---@diagnostic disable-next-line:redundant-parameter
		require("mini.basics").setup({
			-- Options. Set to `false` to disable.
			options = {
				-- Basic options ('number', 'ignorecase', and many more)
				basic = false,
				-- Extra UI features ('winblend', 'cmdheight=0', ...)
				extra_ui = false,
				-- Presets for window borders ('single', 'double', ...)
				win_borders = "bold",
			},

			-- Mappings. Set to `false` to disable.
			mappings = {
				-- Basic mappings (better 'jk', save with Ctrl+S, ...)
				basic = true,

				-- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
				-- Supply empty string to not create these mappings.
				option_toggle_prefix = [[<leader>t]],

				-- Window navigation with <C-hjkl>, resize with <C-arrow>
				windows = false,

				-- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
				move_with_alt = false,
			},

			-- Autocommands. Set to `false` to disable
			autocommands = {
				-- Basic autocommands (highlight on yank, start Insert in terminal, ...)
				basic = false,

				-- Set 'relativenumber' only in linewise and blockwise Visual mode
				relnum_in_visual_mode = false,
			},

			-- Whether to disable showing non-error feedback
			silent = false,
		})
		require("mini.surround").setup({})
		require("mini.bufremove").setup({})
		require("mini.ai").setup({})
		require("mini.icons").setup({})
		---@diagnostic disable-next-line: redundant-parameter
		require("mini.pick").setup({
			mappings = {
				choose = "<CR>",
				choose_in_split = "<C-s>",
				choose_in_tabpage = "<C-t>",
				choose_in_vsplit = "<C-v>",

				choose_marked = "<C-q>",
				mark = "<C-x>",
				mark_all = "<C-a>",
			},
		})

		vim.ui.select = MiniPick.ui_select
		require("mini.extra").setup({})
		require("mini.diff").setup({ view = { style = "sign" } })
		require("mini.git").setup({ command = { split = "vertical" } })
		require("mini.pairs").setup({})
		require("mini.files").setup({
			-- Module mappings created only inside explorer.
			-- Use `''` (empty string) to not create one.
			mappings = {
				close = "q",
				go_in = "",
				go_in_plus = "<CR>",
				go_out = "-",
				go_out_plus = "",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},

			options = {
				permanent_delete = false,
				use_as_default_explorer = true,
			},

			windows = {
				preview = true,
			},
		})

		-- Toggle hidden files
		local show_dotfiles = false
		local filter_show = function(_)
			return true
		end
		local filter_hide = function(fs_entry)
			return not vim.startswith(fs_entry.name, ".")
		end
		local toggle_dotfiles = function()
			show_dotfiles = not show_dotfiles
			local new_filter = show_dotfiles and filter_show or filter_hide
			require("mini.files").refresh({ content = { filter = new_filter } })
		end
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id
				vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
				vim.keymap.set("n", "<Esc>", MiniFiles.close, { buffer = buf_id })
			end,
		})

		-- Customize window
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowOpen",
			callback = function(args)
				local win_id = args.data.win_id
				local config = vim.api.nvim_win_get_config(win_id)
				config.border = "double"
				vim.api.nvim_win_set_config(win_id, config)
			end,
		})

		-- Mini.files
		vim.keymap.set("n", "-", function()
			local currFile = vim.api.nvim_buf_get_name(0)
			if vim.uv.fs_stat(currFile) then
				require("mini.files").open(currFile)
			else
				require("mini.files").open(nil, false)
			end
		end, { desc = "Open parent directory" })
	end,
}
