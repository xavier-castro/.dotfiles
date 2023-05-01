require("xavier.config").init()
return { -- library used by other plugins
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	}, -- makes some plugins dot-repeatable like leap
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	}, -- Surround
	{
		"tpope/vim-surround",
		lazy = false,
	}, -- icons
	{ "kshenoy/vim-signature", lazy = false },
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			local keymap = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			require("hop").setup()

			-- key-mappings
			keymap("", "s", "<cmd>HopChar1<CR>", opts)
			keymap("", "<leader>j", "<cmd>HopLineBC<CR>", opts)
			keymap("", "<leader>k", "<cmd>HopLineAC<CR>", opts)
			keymap("", "<leader><leader>j", "<cmd>HopWordBC<CR>", opts)
			keymap("", "<leader><leader>k", "<cmd>HopWordAC<CR>", opts)

			-- highlights
			vim.api.nvim_exec(
				[[
  highlight HopNextKey gui=bold guifg=#ff007c guibg=None
  highlight HopNextKey1 gui=bold guifg=#00dfff guibg=None
  highlight HopNextKey2 guifg=#2b8db3 guibg=None
]],
				false
			)
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	}, -- Seen in a lot of random plugins
	{
		"MunifTanjim/nui.nvim",
		lazy = false,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
			local Xavier_Fugitive = vim.api.nvim_create_augroup("Xavier_Fugitive", {})

			local autocmd = vim.api.nvim_create_autocmd
			autocmd("BufWinEnter", {
				group = Xavier_Fugitive,
				pattern = "*",
				callback = function()
					if vim.bo.ft ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()
					local opts = {
						buffer = bufnr,
						remap = false,
					}
					vim.keymap.set("n", "<leader>p", function()
						vim.cmd.Git("push")
					end, opts)

					-- rebase always
					vim.keymap.set("n", "<leader>P", function()
						vim.cmd.Git({ "pull", "--rebase" })
					end, opts)

					-- NOTE: It allows me to easily set the branch i am pushing and any tracking
					-- needed if i did not set the branch up correctly
					vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
				end,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				icons = false,
			})
			vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {
				silent = true,
				noremap = true,
			})
			vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", {
				silent = true,
				noremap = true,
			})
		end,
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.undotreetoggle)
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({
				signs = true, -- show icons in the signs column
				sign_priority = 8, -- sign priority
				-- keywords recognized as todo comments
				keywords = {
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false, -- configure signs for some keywords individually
					},
					TODO = { icon = " ", color = "info" },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO", "MARK" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
				gui_style = {
					fg = "NONE", -- The gui style to use for the fg highlight group.
					bg = "BOLD", -- The gui style to use for the bg highlight group.
				},
				merge_keywords = true, -- when true, custom keywords will be merged with the defaults
				-- highlighting of the line containing the todo comment
				-- * before: highlights before the keyword (typically comment characters)
				-- * keyword: highlights of the keyword
				-- * after: highlights after the keyword (todo text)
				highlight = {
					multiline = true, -- enable multine todo comments
					multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
					multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
					before = "", -- "fg" or "bg" or empty
					keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
					after = "fg", -- "fg" or "bg" or empty
					pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
					comments_only = true, -- uses treesitter to match keywords in comments only
					max_line_len = 400, -- ignore lines longer than this
					exclude = {}, -- list of file types to exclude highlighting
				},
				-- list of named colors where we try to extract the guifg from the
				-- list of highlight groups or use the hex color if hl not found as a fallback
				colors = {
					error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
					warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
					info = { "DiagnosticInfo", "#2563EB" },
					hint = { "DiagnosticHint", "#10B981" },
					default = { "Identifier", "#7C3AED" },
					test = { "Identifier", "#FF00FF" },
				},
				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					-- regex that will be used to match keywords.
					-- don't replace the (KEYWORDS) placeholder
					pattern = [[\b(KEYWORDS):]], -- ripgrep regex
					-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
				},
			})

			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })
		end,
	},
	{
		"theprimeagen/harpoon",
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")
			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", ";e", ui.toggle_quick_menu)
			vim.keymap.set("n", "<C-h>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<C-j>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<C-k>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<C-l>", function()
				ui.nav_file(4)
			end)
		end,
	},
	{
		"akinsho/nvim-bufferline.lua",
		config = function()
			local status, bufferline = pcall(require, "bufferline")
			if not status then
				return
			end

			bufferline.setup({
				options = {
					mode = "tabs",
					separator_style = "slant",
					always_show_bufferline = false,
					show_buffer_close_icons = false,
					show_close_icon = false,
					color_icons = true,
				},
				highlights = {
					separator = {
						fg = "#073642",
						bg = "#002b36",
					},
					separator_selected = {
						fg = "#073642",
					},
					background = {
						fg = "#657b83",
						bg = "#002b36",
					},
					buffer_selected = {
						fg = "#fdf6e3",
					},
					fill = {
						bg = "#073642",
					},
				},
			})

			vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
			vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			config = function()
				local CodeGPTModule = require("codegpt")
				local status, lualine = pcall(require, "lualine")
				if not status then
					return
				end

				lualine.setup({
					options = {
						icons_enabled = true,
						theme = "auto",
						section_separators = { left = "", right = "" },
						component_separators = { left = "", right = "" },
						disabled_filetypes = {},
					},
					sections = {
						lualine_a = { "mode" },
						lualine_b = { "branch" },
						lualine_c = {
							{
								"filename",
								file_status = true, -- displays file status (readonly status, modified status)
								path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
							},
						},
						lualine_x = {
							{
								"diagnostics",
								sources = { "nvim_diagnostic" },
								symbols = { error = " ", warn = " ", info = " ", hint = " " },
							},
							CodeGPTModule.get_status,
							"encoding",
							"filetype",
						},
						lualine_y = { "progress" },
						lualine_z = { "location" },
					},
					inactive_sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_c = {
							{
								"filename",
								file_status = true, -- displays file status (readonly status, modified status)
								path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
							},
						},
						lualine_x = { "location" },
						lualine_y = {},
						lualine_z = {},
					},
					tabline = {},
					extensions = { "fugitive" },
				})
			end,
		},
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			local c = require("xavier.util.colors")

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
				c.ColorMyPencils()
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
				c.ColorMyPencils()
			end)
		end,
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			local c = require("xavier.util.colors")

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
				c.ColorMyPencils()
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
				c.ColorMyPencils()
			end)
		end,
	},
	{
		"levouh/tint.nvim",
		config = function()
			require("tint").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"akinsho/nvim-toggleterm.lua",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
				start_in_insert = true,
				persist_size = true,
				direction = "horizontal",
				close_on_exit = true, -- close the terminal window when the process exits
				shell = vim.o.shell, -- change the default shell
			})
		end,
	},
}
