return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",
	keys = {
		{
			"<leader>ff",
			":Telescope find_files<CR>",
			mode = { "n" },
			desc = "Lists files in your current working directory, respects .gitignore",
		},
		{
			"<leader>fg",
			":Telescope live_grep<CR>",
			mode = { "n" },
			desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore. (Requires ripgrep)",
		},
		{
			"<leader>fh",
			":Telescope help_tags<CR>",
			mode = { "n" },
			desc = "",
		},
		{
			"<leader>fw",
			":Telescope grep_string<CR>",
			mode = { "n" },
			desc = "Search for the word under your cursor in your current working directory",
		},
		{
			"<leader>fk",
			":Telescope keymaps<CR>",
			mode = { "n" },
			desc = "",
		},
	},

	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
				},
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		-- vim.keymap.set("n", "<C-p>", builtin.git_files, {})
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
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

		-- keymaps
		vim.keymap.set("n", ";f", function()
			builtin.find_files({
				no_ignore = false,
				hidden = true,
			})
		end)
		vim.keymap.set("n", ";r", function()
			builtin.live_grep()
		end)
		vim.keymap.set("n", "\\\\", function()
			builtin.buffers()
		end)
		vim.keymap.set("n", ";t", function()
			builtin.help_tags()
		end)
		vim.keymap.set("n", ";;", function()
			builtin.resume()
		end)
		vim.keymap.set("n", ";e", function()
			builtin.diagnostics()
		end)
		vim.keymap.set("n", ";o", function()
			builtin.oldfiles()
		end)
	end,
}
