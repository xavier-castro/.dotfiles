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
	{ "monaqa/dial.nvim" },
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
			"rafamadriz/friendly-snippets",
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
			local scrollbar = require("scrollbar")
			scrollbar.setup({})
		end,
	},
	{
		"Pocco81/true-zen.nvim",
		keys = {
			{
				"<leader>zz",
				function()
					local truezen = require("true-zen")
					truezen.ataraxis()
				end,
				desc = "zen",
			},
		},
	},
	{ "anuvyklack/hydra.nvim", event = "VeryLazy" },
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = {
				"markdown",
			}
		end,
		ft = {
			"markdown",
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
}
