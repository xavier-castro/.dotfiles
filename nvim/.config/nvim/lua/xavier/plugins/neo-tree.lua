local utils = require("xavier.utils")

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	keys = {
		{
			"<leader>e",
			"<cmd>Neotree toggle<cr>",
			desc = "Toggle neo-tree",
		},
		{
			"<leader>o",
			function()
				if vim.bo.filetype == "neo-tree" then
					-- The next code is heavily dependant on the
					-- window id history autocmd
					local win_history = vim.t.win_history
					local prev_win = win_history[1]

					-- If the previous window is a neo-tree window, then
					-- look for the window before that one.
					if utils.buf_filetype_from_winid(prev_win) == "neo-tree" then
						prev_win = win_history[2]
					end

					if vim.fn.win_getid() == prev_win then
						-- Go to the window to the right as a fallback
						vim.cmd.wincmd("l")
					else
						-- Go to the previous window
						vim.fn.win_gotoid(prev_win)
					end
				else
					-- Is a mistery to me why executing `vim.cmd.Neotree("focus")`
					-- is appending an unexpected additional window id.
					vim.cmd.Neotree("focus")
				end
			end,
			desc = "Focus neo-tree",
		},
		{
			"<leader>rb",
			"<cmd>Neotree filesystem reveal left<cr>",
			desc = "Reveal file in neo-tree",
		},
	},
}
