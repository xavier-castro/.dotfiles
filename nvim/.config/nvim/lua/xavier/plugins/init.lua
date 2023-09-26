return {

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
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {
					config = {
						icon_preset = "diamond",
					},
				}, -- Adds pretty icons to your documents
				-- Required for export markdown
				["core.integrations.treesitter"] = {},
				["core.export.markdown"] = {},
				["core.export"] = {},
				["core.summary"] = {},
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
						},
						default_workspace = "notes",
					},
				},
			},
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
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
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "keyvchan/telescope-find-pickers.nvim" },
			{ "kkharji/sqlite.lua" },
			{
				"prochri/telescope-all-recent.nvim",
				config = function()
					require("telescope-all-recent").setup({})
				end,
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
	{
		"Bryley/neoai.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		cmd = {
			"NeoAI",
			"NeoAIOpen",
			"NeoAIClose",
			"NeoAIToggle",
			"NeoAIContext",
			"NeoAIContextOpen",
			"NeoAIContextClose",
			"NeoAIInject",
			"NeoAIInjectCode",
			"NeoAIInjectContext",
			"NeoAIInjectContextCode",
		},
		keys = {
			{ "<leader>as", desc = "summarize text" },
			{ "<leader>ag", desc = "generate git message" },
		},
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
		event = "VeryLazy",
		config = function()
			local keymap = vim.api.nvim_set_keymap
			local opts = {
				noremap = true,
				silent = true,
			}
			require("hop").setup()

			-- key-mappings
			keymap("", "s", "<cmd>HopChar1<CR>", opts)
			keymap("", "<leader>j", "<cmd>HopWordBC<CR>", opts)
			keymap("", "<leader>k", "<cmd>HopWordAC<CR>", opts)

			-- highlights
			vim.cmd([[
                    highlight HopNextKey gui=bold guifg=#ff007c guibg=None
                    highlight HopNextKey1 gui=bold guifg=#00dfff guibg=None
                    highlight HopNextKey2 guifg=#2b8db3 guibg=None
                ]])
		end,
	},
}
