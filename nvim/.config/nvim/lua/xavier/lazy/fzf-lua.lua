return {
	"ibhagwan/fzf-lua",
	lazy = false,
	event = "BufEnter",
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			mode = { "n" },
			desc = "Lists files in your current working directory, respects .gitignore",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			mode = { "n" },
			desc =
			"Search for a string in your current working directory and get results live as you type, respects .gitignore. (Requires ripgrep)",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").help_tags()
			end,
			mode = { "n" },
			desc = "",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			mode = { "n" },
			desc = "Search for the word under your cursor in your current working directory",
		},
		{
			";k",
			function()
				require("fzf-lua").keymaps()
			end,
			mode = { "n" },
			desc = "Display keymaps",
		},
	},

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- optional for icons
	},

	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				preview = {
					default = "bat", -- use bat for previewing files
				},
			},
			keymap = {
				builtin = {
					["<C-k>"] = "preview-page-up",
					["<C-j>"] = "preview-page-down",
				},
			},
		})

		-- keymaps
		vim.keymap.set("n", ";f", function()
			fzf.files({
				hidden = true,
			})
		end)
		vim.keymap.set("n", ";r", function()
			fzf.live_grep()
		end)
		vim.keymap.set("n", "\\\\", function()
			fzf.buffers()
		end)
		vim.keymap.set("n", ";t", function()
			fzf.help_tags()
		end)
		vim.keymap.set("n", ";;", function()
			fzf.resume()
		end)
		vim.keymap.set("n", ";e", function()
			fzf.diagnostics()
		end)
		vim.keymap.set("n", ";o", function()
			fzf.oldfiles()
		end)
	end,
}
