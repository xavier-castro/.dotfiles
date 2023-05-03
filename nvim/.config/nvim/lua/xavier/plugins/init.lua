return {
	{
		"svrana/neosolarized.nvim",
		dependencies = { "tjdevries/colorbuddy.nvim" },
		lazy = false,
	},
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-commentary" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{ "norcalli/nvim-colorizer.lua" },
	{ "kshenoy/vim-signature" },
	{ "justinmk/vim-sneak" },
	{ "unblevable/quick-scope" },
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/playground" },
			{ "nvim-treesitter/nvim-treesitter-context" },
		},
	},
	{ "theprimeagen/harpoon" },
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
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"windwp/nvim-autopairs",
			"onsails/lspkind-nvim",
			"roobert/tailwindcss-colorizer-cmp.nvim",
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
		"levouh/tint.nvim",
		config = function()
			require("tint").setup()
		end,
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{ url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
}
