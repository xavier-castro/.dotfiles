return {
	{
		"Shatur/neovim-session-manager",
		lazy = false,
		config = function()
			require("session_manager").setup({
				autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
			})
		end,
	},
	{
		"svrana/neosolarized.nvim",
		dependencies = {
			"tjdevries/colorbuddy.nvim",
		},
		lazy = false,
	},
	{
		"olimorris/onedarkpro.nvim",
		lazy = false,
		config = function()
			(require("onedarkpro")).setup({
				options = {
					transparency = true,
				},
			})
		end,
	},
	{ "tpope/vim-obsession" },
	{
		"goolord/alpha-nvim",
		lazy = false,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		opts = {
			transparent = true,
		},
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
	{
		"nvim-pack/nvim-spectre",
	},
	{
		"mrjones2014/nvim-ts-rainbow",
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
	{
		"tpope/vim-surround",
	},
	{
		"tpope/vim-repeat",
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"tpope/vim-commentary",
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			(require("gitsigns")).setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
	},
	{
		"kshenoy/vim-signature",
	},
	{
		"justinmk/vim-sneak",
	},
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
	{
		"theprimeagen/harpoon",
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"theprimeagen/refactoring.nvim",
	},
	{
		"mbbill/undotree",
	},
	{
		"folke/trouble.nvim",
	},
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
	{
		"akinsho/nvim-bufferline.lua",
	},
	{
		"nvim-lualine/lualine.nvim",
	},
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
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
	},
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
	},
	{
		"windwp/nvim-autopairs",
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"github/copilot.vim",
	},
	{
		"akinsho/nvim-toggleterm.lua",
	},
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
			(require("scrollbar")).setup()
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
				(require("zen-mode")).setup({
					window = {
						width = 90,
						options = {},
					},
				});
				(require("zen-mode")).toggle()
				vim.wo.wrap = false
				vim.wo.number = true
				vim.wo.rnu = true
			end)
			vim.keymap.set("n", "<leader>zZ", function()
				(require("zen-mode")).setup({
					window = {
						width = 80,
						options = {},
					},
				});
				(require("zen-mode")).toggle()
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
			(require("tint")).setup({})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			(require("indent_blankline")).setup({
				show_current_context = true,
			})
		end,
	},
}
