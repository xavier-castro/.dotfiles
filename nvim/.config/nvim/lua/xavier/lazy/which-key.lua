return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = function(ctx)
			return ctx.plugin and 0 or 200
		end,
		expand = 1,
		notify = false,
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader>f", group = "Find/File" },
				{ "<leader>p", group = "Project/Search" },
				{ "<leader>v", group = "Vim/Help" },
				{ "<leader>c", group = "Code" },
				{ "<leader>g", group = "Git" },
				{ "<leader>s", group = "Search/Replace" },
				{ "<leader>t", group = "Toggle/Terminal" },
				{ "<leader>w", group = "Window" },
				{ "<leader>b", group = "Buffer" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
		{
			"<c-w><space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Add keybindings with descriptions
		wk.add({
			-- File operations
			{ "-", desc = "Oil File Manager" },
			{ "<leader>e", desc = "Focus File Tree" },

			-- Navigation & Quick Access
			{ "<C-f>", desc = "Tmux Sessionizer" },
			{ "<M-o>", desc = "Open Opencode" },
			{ "<M-c>", desc = "Open Claude CLI" },

			-- Harpoon
			{ "<leader>a", desc = "Harpoon Add File" },
			{ "<C-e>", desc = "Harpoon Menu" },
			{ "<C-h>", desc = "Harpoon File 1" },
			{ "<C-t>", desc = "Harpoon File 2" },
			{ "<C-n>", desc = "Harpoon File 3" },
			{ "<C-s>", desc = "Harpoon File 4" },

			-- Telescope groups
			{ "<leader>f", group = "Find" },
			{ "<leader>fP", desc = "Find Plugin Files" },
			{ "<leader>pf", desc = "Find Files" },
			{ "<leader>pv", desc = "File Browser" },
			
			{ "<leader>p", group = "Project" },
			{ "<leader>ps", desc = "Grep String" },
			{ "<leader>pws", desc = "Grep Word Under Cursor" },
			{ "<leader>pWs", desc = "Grep WORD Under Cursor" },

			{ "<leader>v", group = "Vim" },
			{ "<leader>vh", desc = "Help Tags" },
			{ "<leader>vwm", desc = "Start Vim With Me" },
			{ "<leader>svwm", desc = "Stop Vim With Me" },

			-- Code operations
			{ "<leader>c", group = "Code" },
			{ "<leader>cf", desc = "Format Buffer" },
			{ "<leader>zig", desc = "LSP Restart" },

			-- Text manipulation
			{ "<leader>y", desc = "Yank to System", mode = { "n", "v" } },
			{ "<leader>Y", desc = "Yank Line to System" },
			{ "<leader>p", desc = "Paste Without Overwrite", mode = "x" },
			{ "<leader>d", desc = "Delete to Black Hole", mode = { "n", "v" } },

			-- Search and replace
			{ "<leader>s", desc = "Search & Replace Word Under Cursor" },

			-- Quick list navigation
			{ "<C-k>", desc = "Next Quickfix" },
			{ "<C-j>", desc = "Prev Quickfix" },
			{ "<leader>k", desc = "Next Location List" },
			{ "<leader>j", desc = "Prev Location List" },

			-- Telescope shortcuts with semicolon
			{ ";", group = "Telescope" },
			{ ";f", desc = "Find Files" },
			{ ";r", desc = "Live Grep" },
			{ ";t", desc = "Help Tags" },
			{ ";e", desc = "Diagnostics" },
			{ ";s", desc = "Treesitter Symbols" },
			{ ";c", desc = "LSP Incoming Calls" },
			{ ";;", desc = "Resume Last Picker" },
			{ "\\\\", desc = "Open Buffers" },

			-- Git (for future git plugins)
			{ "<leader>g", group = "Git" },

			-- Visual mode specific
			{ "J", desc = "Move Selection Down", mode = "v" },
			{ "K", desc = "Move Selection Up", mode = "v" },

			-- Insert mode
			{ "jk", desc = "Escape to Normal", mode = "i" },
		})
	end,
}