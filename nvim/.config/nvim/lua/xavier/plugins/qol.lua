return {
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-sleuth",
	{ "machakann/vim-sandwich" },
	{ "vim-scripts/ReplaceWithRegister" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-commentary" },
	{ "tpope/vim-dadbod" },
	{ "kshenoy/vim-signature" },
	{ "mg979/vim-visual-multi", branch = "master" },
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
		"windwp/nvim-autopairs",
		-- Optional dependency
		dependencies = { "hrsh7th/nvim-cmp", "windwp/nvim-ts-autotag" },
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		opts = {},
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		end,
	},
	{
		"mbbill/undotree",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				icons = false,
			})
			vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({})
		end,
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
	{
		"github/copilot.vim",
		config = function()
			local r = require("xavier.utils.remaps")
			vim.g.copilot_filetypes = {
				TelescopePrompt = false,
			}
			vim.g.copilot_no_tab_map = true
			r.map("i", "<C-a>", "copilot#Accept()", "Accepts copilot suggestion", {
				script = true,
				expr = true,
				silent = true,
			})
			r.map("i", "<C-x>", "copilot#Dismiss()", "Dismisses copilot suggestion", {
				script = true,
				expr = true,
				silent = true,
			})
		end,
	},
	{
		{
			"stevearc/conform.nvim",
			event = "BufWritePre",
			cmd = "ConformInfo",
			keys = {
				{
					"<leader>lf",
					function()
						require("conform").format({
							lsp_fallback = true,
							async = false,
							timeout_ms = 10000,
						})
					end,
					mode = { "n", "v" },
					desc = "Conform Format file or range",
				},
			},
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
					javascriptreact = { { "prettierd", "prettier" } },
					typescriptreact = { { "prettierd", "prettier" } },
					python = { "isort", "black" },
					go = { "gofumpt", "goimports" },
					json = { { "prettierd", "prettier" } },
					jsonc = { { "prettierd", "prettier" } },
				},
			},
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			-- This module contains a number of default definitions
			local rainbow_delimiters = require("rainbow-delimiters")

			---@type rainbow_delimiters.config
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
	-- lazy.nvim
	{
		"robitx/gp.nvim",
		config = function()
			local openai_api_key = vim.fn.getenv("OPENAI_API_KEY")
			require("gp").setup({
				openai_api_key = openai_api_key,
			})
			-- VISUAL mode mappings
			-- s, x, v modes are handled the same way by which_key
			require("which-key").register({
				-- ...
				["<C-g>"] = {
					c = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
					v = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
					t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat" },

					["<C-x>"] = { ":'<,'>GpChatNew split<CR>", "Visual Chat New split" },
					["<C-v>"] = { ":'<,'>GpChatNew vsplit<CR>", "Visual Chat New vsplit" },
					["<C-t>"] = { ":'<,'>GpChatNew tabnew<CR>", "Visual Chat New tabnew" },

					r = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
					a = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append" },
					b = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend" },
					e = { ":<C-u>'<,'>GpEnew<cr>", "Visual Enew" },
					p = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },

					x = { ":<C-u>'<,'>GpContext<cr>", "Visual Toggle Context" },

					n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
					s = { "<cmd>GpStop<cr>", "Stop" },

					-- optional Whisper commands
					w = { ":<C-u>'<,'>GpWhisper<cr>", "Whisper" },
					R = { ":<C-u>'<,'>GpWhisperRewrite<cr>", "Whisper Visual Rewrite" },
					A = { ":<C-u>'<,'>GpWhisperAppend<cr>", "Whisper Visual Append" },
					B = { ":<C-u>'<,'>GpWhisperPrepend<cr>", "Whisper Visual Prepend" },
					E = { ":<C-u>'<,'>GpWhisperEnew<cr>", "Whisper Visual Enew" },
					P = { ":<C-u>'<,'>GpWhisperPopup<cr>", "Whisper Visual Popup" },
				},
				-- ...
			}, {
				mode = "v", -- VISUAL mode
				prefix = "",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = true,
			})

			-- NORMAL mode mappings
			require("which-key").register({
				-- ...
				["<C-g>"] = {
					c = { "<cmd>GpChatNew<cr>", "New Chat" },
					t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
					f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

					["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
					["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
					["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

					r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
					a = { "<cmd>GpAppend<cr>", "Append" },
					b = { "<cmd>GpPrepend<cr>", "Prepend" },
					e = { "<cmd>GpEnew<cr>", "Enew" },
					p = { "<cmd>GpPopup<cr>", "Popup" },

					x = { "<cmd>GpContext<cr>", "Toggle Context" },
					n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
					s = { "<cmd>GpStop<cr>", "Stop" },

					-- optional Whisper commands
					w = { "<cmd>GpWhisper<cr>", "Whisper" },
					R = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
					A = { "<cmd>GpWhisperAppend<cr>", "Whisper Append" },
					B = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend" },
					E = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
					P = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
				},
				-- ...
			}, {
				mode = "n", -- NORMAL mode
				prefix = "",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = true,
			})

			-- INSERT mode mappings
			require("which-key").register({
				-- ...
				["<C-g>"] = {
					c = { "<cmd>GpChatNew<cr>", "New Chat" },
					t = { "<cmd>GpChatToggle<cr>", "Toggle Popup Chat" },
					f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

					["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
					["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
					["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

					r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
					a = { "<cmd>GpAppend<cr>", "Append" },
					b = { "<cmd>GpPrepend<cr>", "Prepend" },
					e = { "<cmd>GpEnew<cr>", "Enew" },
					p = { "<cmd>GpPopup<cr>", "Popup" },

					x = { "<cmd>GpContext<cr>", "Toggle Context" },
					n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
					s = { "<cmd>GpStop<cr>", "Stop" },

					-- optional Whisper commands
					w = { "<cmd>GpWhisper<cr>", "Whisper" },
					R = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
					A = { "<cmd>GpWhisperAppend<cr>", "Whisper Append" },
					B = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend" },
					E = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
					P = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
				},
				-- ...
			}, {
				mode = "i", -- INSERT mode
				prefix = "",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = true,
			})

			-- or setup with your own config (see Install > Configuration in Readme)
			-- require("gp").setup(config)

			-- shortcuts might be setup here (see Usage > Shortcuts in Readme)
		end,
	},
}
