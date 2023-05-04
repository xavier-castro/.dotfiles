return {
	{
		"svrana/neosolarized.nvim",
		dependencies = { "tjdevries/colorbuddy.nvim" },
		lazy = false,
	},
	{ "olimorris/onedarkpro.nvim", lazy = false },
	{ "Mofiqul/vscode.nvim", lazy = false },
	{ "rose-pine/neovim", name = "rose-pine", lazy = false, opts = { disable_background = true } },
	{
		"AckslD/swenv.nvim",
		config = function()
			require("swenv").setup({
				-- Should return a list of tables with a `name` and a `path` entry each.
				-- Gets the argument `venvs_path` set below.
				-- By default just lists the entries in `venvs_path`.
				get_venvs = function(venvs_path)
					return require("swenv.api").get_venvs(venvs_path)
				end,
				-- Path passed to `get_venvs`.
				venvs_path = vim.fn.expand("~/venvs"),
				-- Something to do after setting an environment
				post_set_venv = nil,
			})
		end,
	},
	{ "nvim-pack/nvim-spectre" },
	{ "mrjones2014/nvim-ts-rainbow" },
	{
		"willothy/veil.nvim",
		lazy = true,
		dependencies = {
			-- All optional, only required for the default setup.
			-- If you customize your config, these aren't necessary.
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = true,
		-- or configure with:
		-- opts = { ... }
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		config = function()
			vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
			vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
			vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
			vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
		end,
	},
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-commentary" },
	{ "RRethy/vim-illuminate" },
	{ "phaazon/hop.nvim", branch = "v2" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{ "norcalli/nvim-colorizer.lua" },
	{ "kshenoy/vim-signature" },
	{ "justinmk/vim-sneak" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/playground" },
			{ "nvim-treesitter/nvim-treesitter-context" },
		},
	},
	{ "theprimeagen/harpoon" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "theprimeagen/refactoring.nvim" },
	{ "mbbill/undotree" },
	{ "folke/trouble.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "sar/web-devicons.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	}, -- Bufferline + Lualine
	{ "akinsho/nvim-bufferline.lua" },
	{ "nvim-lualine/lualine.nvim" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		event = "InsertEnter",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"windwp/nvim-autopairs",
			"onsails/lspkind-nvim",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"nvim-lua/lsp-status.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"b0o/schemastore.nvim",
			"williamboman/mason-lspconfig.nvim",
			"MunifTanjim/prettier.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
	},
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "glepnir/lspsaga.nvim", event = "LspAttach" },
	{ "windwp/nvim-autopairs" },
	{ "windwp/nvim-ts-autotag" },
	{ "github/copilot.vim" },
	{ "akinsho/nvim-toggleterm.lua" },
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	},

	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},

	{
		"dpayne/CodeGPT.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("codegpt.config")
		end,
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			vim.keymap.set("n", "<leader>zz", function()
				require("zen-mode").setup({
					window = {
						width = 90,
						options = {},
					},
				})
				require("zen-mode").toggle()
				vim.wo.wrap = false
				vim.wo.number = true
				vim.wo.rnu = true
			end)

			vim.keymap.set("n", "<leader>zZ", function()
				require("zen-mode").setup({
					window = {
						width = 80,
						options = {},
					},
				})
				require("zen-mode").toggle()
				vim.wo.wrap = false
				vim.wo.number = false
				vim.wo.rnu = false
				vim.opt.colorcolumn = "0"
			end)
		end,
	},
	{
		"levouh/tint.nvim",
		config = function()
			require("tint").setup({})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				show_current_context = true,
				-- show_current_context_start = true,
			})
		end,
	},
}
