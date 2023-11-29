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
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
			vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
			vim.keymap.set("n", "K", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					-- choose one of coc.nvim and nvim lsp
					vim.fn.CocActionAsync("definitionHover") -- coc.nvim
					vim.lsp.buf.hover()
				end
			end)
		end,
	},
	{
		"mbbill/undotree",
		opts = {},
		keys = {
			{
				"<leader>u",
				function()
					vim.cmd.UndotreeToggle()
				end,
				desc = "Toggle undotree",
			},
		},
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	{
		"folke/trouble.nvim",
		keys = {
			{
				"<leader>xq",
				function()
					require("trouble").toggle("quickfix")
				end,
				desc = "Toggle quickfix",
			},
			{
				"<leader>xx",
				function()
					require("trouble").toggle()
				end,
				desc = "Trouble Toggle",
			},
			{
				"<leader>xw",
				function()
					require("trouble").toggle("workspace_diagnostics")
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>xd",
				function()
					require("trouble").toggle("document_diagnostics")
				end,
				desc = "Document Diagnostics",
			},
			{
				"<leader>xl",
				function()
					require("trouble").toggle("loclist")
				end,
				desc = "Loclist",
			},
			{
				"gR",
				function()
					require("trouble").toggle("lsp_references")
				end,
				desc = "LSP References",
			},
		},
		config = function()
			require("trouble").setup({
				icons = false,
			})
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
			vim.keymap.set({ "i", "n" }, "<M-p>", ":Copilot panel<cr>")
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
	-- lazy.nvim
	{
		"robitx/gp.nvim",
		config = function()
			local openai_api_key = vim.fn.getenv("OPENAI_API_KEY")
			require("gp").setup({
				openai_api_key = openai_api_key,
				hooks = {
					InspectPlugin = function(plugin, params)
						local bufnr = vim.api.nvim_create_buf(false, true)
						local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(plugin))
						local params_info = string.format("Command params:\n%s", vim.inspect(params))
						local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
						vim.api.nvim_win_set_buf(0, bufnr)
					end,

					-- GpImplement rewrites the provided selection/range based on comments in it
					Implement = function(gp, params)
						local template = "Having following from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please rewrite this according to the contained instructions."
							.. "\n\nRespond exclusively with the snippet that should replace the selection above."

						local agent = gp.get_command_agent()
						gp.Info("Implementing selection with agent: " .. agent.name)

						gp.Prompt(
							params,
							gp.Target.rewrite,
							nil, -- command will run directly without any prompting for user input
							agent.model,
							template,
							agent.system_prompt
						)
					end,

					-- your own functions can go here, see README for more examples like
					-- :GpExplain, :GpUnitTests.., :GpTranslator etc.

					-- example of making :%GpChatNew a dedicated command which
					-- opens new chat with the entire current buffer as a context
					BufferChatNew = function(gp, _)
						-- call GpChatNew command in range mode on whole buffer
						vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
					end,

					-- -- example of adding command which opens new chat dedicated for translation
					-- Translator = function(gp, params)
					-- 	local agent = gp.get_command_agent()
					-- 	local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
					-- 	gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
					-- end,

					-- -- example of adding command which writes unit tests for the selected code
					-- UnitTests = function(gp, params)
					-- 	local template = "I have the following code from {{filename}}:\n\n"
					-- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
					-- 		.. "Please respond by writing table driven unit tests for the code above."
					-- 	local agent = gp.get_command_agent()
					-- 	gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
					-- end,

					-- example of adding command which explains the selected code
					Explain = function(gp, params)
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please respond by explaining the code above."
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
					end,
				},
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
	{
		"nvim-neorg/neorg",
		ft = "norg", -- lazy load on filetype
		cmd = "Neorg", -- lazy load on command, allows you to autocomplete :Neorg regardless of whether it's loaded yet
		--  (you could also just remove both lazy loading things)
		priority = 30, -- treesitter is on default priority of 50, neorg should load after it.
		build = ":Neorg sync-parsers",
		lazy = false,
		config = function()
			require("neorg").setup({

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
								main = "~/neorg/main",
								school = "~/neorg/school",
								projects = "~/neorg/projects",
								notepad = "~/neorg/notepad",
							},
							default_workspace = "main",
						},
					},
				},
			})
			-- Neorg
			vim.keymap.set("n", "<LocalLeader>r", "<cmd>Neorg return<cr>")
			vim.keymap.set("n", "<LocalLeader>gw", "<cmd>Neorg workspace<cr>")
			vim.keymap.set("n", "<LocalLeader>gg", "<cmd>Neorg workspace notepad<cr>")
			vim.keymap.set("n", "<LocalLeader>gj", "<cmd>Neorg journal<cr>")
			vim.keymap.set("n", "<LocalLeader>gi", "<cmd>Neorg index<cr>")
			vim.keymap.set("n", "<LocalLeader>cc", "<cmd>Neorg toggle-concealer<cr>")
		end,
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
}
