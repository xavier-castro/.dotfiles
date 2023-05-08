return {
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"no-clown-fiesta/no-clown-fiesta.nvim",
		lazy = false,
		opts = {
			lsp = { underline = true },
		},
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
	},
	{ "kaiuri/nvim-juliana", lazy = false },
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		opts = {
			transparent = true,
		},
	},
	{
		"mhartington/oceanic-next",
		lazy = false,
		config = function() end,
	},
	{
		"svrana/neosolarized.nvim",
		dependencies = {
			"tjdevries/colorbuddy.nvim",
		},
		lazy = false,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		opts = {
			disable_background = true,
		},
	},
	{ "machakann/vim-sandwich" },
	{ "vim-scripts/ReplaceWithRegister" },
	{ "nvim-pack/nvim-spectre" },
	{ "mrjones2014/nvim-ts-rainbow" },
	{ "godlygeek/tabular" },

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
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			(require("gitsigns")).setup()
		end,
	},
	{ "norcalli/nvim-colorizer.lua" },
	{ "kshenoy/vim-signature" },
	{ "justinmk/vim-sneak" },
	{ "mg979/vim-visual-multi", branch = "master" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{
				"nvim-treesitter/playground",
			},
			{
				"nvim-treesitter/nvim-treesitter-context",
			},
		},
	},
	{ "theprimeagen/harpoon" },
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "mbbill/undotree" },
	{ "folke/trouble.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"sar/web-devicons.nvim",
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
			},
			{
				"nvim-lua/plenary.nvim",
			},
			{
				"nvim-telescope/telescope-ui-select.nvim",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
	},
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
		event = {
			"BufReadPre",
			"BufNewFile",
		},
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
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	{ "folke/zen-mode.nvim", event = "VeryLazy" },
	{
		"levouh/tint.nvim",
		config = function()
			(require("tint")).setup({})
		end,
		event = "VeryLazy",
	},
	-- Lazy
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
}
