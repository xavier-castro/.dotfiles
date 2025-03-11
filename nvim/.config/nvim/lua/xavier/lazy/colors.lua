function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	-- lazy
	-- NOTE: VSCode
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Lua:
			-- For dark theme (neovim's default)
			vim.o.background = "dark"
			-- For light theme
			-- vim.o.background = "light"

			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				-- Alternatively set style in setup
				-- style = 'light'

				-- Enable transparent background
				transparent = true,

				-- Enable italic comment
				italic_comments = true,

				-- Underline `@markup.link.*` variants
				underline_links = true,

				-- Disable nvim-tree background color
				disable_nvimtree_bg = true,

				-- Apply theme colors to terminal
				terminal_colors = true,

				-- Override colors (see ./lua/vscode/colors.lua)
				-- color_overrides = {
				-- 	vscLineNumber = "#FFFFFF",
				-- },

				-- Override highlight groups (see ./lua/vscode/theme.lua)
				group_overrides = {
					-- this supports the same val table as vim.api.nvim_set_hl
					-- use colors from this colorscheme by requiring vscode.colors!
					Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
				},
			})
			-- require('vscode').load()

			-- load the theme without affecting devicon colors.
			vim.cmd.colorscheme("vscode")
		end,
	},
	-- NOTE: Neosolarized
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},
	-- NOTE: Rose Pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				variant = "main", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = true,
				-- disable_background = true,
				-- 	disable_nc_background = false,
				-- 	disable_float_background = false,
				-- extend_background_behind_borders = false,
				styles = {
					bold = false,
					italic = false,
					transparency = true,
				},
				highlight_groups = {
					ColorColumn = { bg = "#1C1C21" },
					Normal = { bg = "none" }, -- Main background remains transparent
					Pmenu = { bg = "", fg = "#e0def4" }, -- Completion menu background
					PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" }, -- Highlighted completion item
					PmenuSbar = { bg = "#191724" }, -- Scrollbar background
					PmenuThumb = { bg = "#9ccfd8" }, -- Scrollbar thumb
				},
				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},
			})
		end,
	},
	-- NOTE: OneDark Pro
	{
		"olimorris/onedarkpro.nvim",
		config = function()
			require("onedarkpro").setup({
				colors = {}, -- Override default colors or create your own
				highlights = {}, -- Override default highlight groups or create your own
				styles = { -- For example, to apply bold and italic, use "bold,italic"
					types = "NONE", -- Style that is applied to types
					methods = "NONE", -- Style that is applied to methods
					numbers = "NONE", -- Style that is applied to numbers
					strings = "NONE", -- Style that is applied to strings
					comments = "NONE", -- Style that is applied to comments
					keywords = "NONE", -- Style that is applied to keywords
					constants = "NONE", -- Style that is applied to constants
					functions = "NONE", -- Style that is applied to functions
					operators = "NONE", -- Style that is applied to operators
					variables = "NONE", -- Style that is applied to variables
					parameters = "NONE", -- Style that is applied to parameters
					conditionals = "NONE", -- Style that is applied to conditionals
					virtual_text = "NONE", -- Style that is applied to virtual text
				},
				filetypes = { -- Override which filetype highlight groups are loaded
					c = true,
					comment = true,
					go = true,
					html = true,
					java = true,
					javascript = true,
					json = true,
					lua = true,
					markdown = true,
					php = true,
					python = true,
					ruby = true,
					rust = true,
					scss = true,
					toml = true,
					typescript = true,
					typescriptreact = true,
					vue = true,
					xml = true,
					yaml = true,
				},
				plugins = { -- Override which plugin highlight groups are loaded
					aerial = true,
					barbar = true,
					codecompanion = true,
					copilot = true,
					dashboard = true,
					flash_nvim = true,
					gitgraph_nvim = true,
					gitsigns = true,
					hop = true,
					indentline = true,
					leap = true,
					lsp_saga = true,
					lsp_semantic_tokens = true,
					marks = true,
					mini_diff = true,
					mini_icons = true,
					mini_indentscope = true,
					neotest = true,
					neo_tree = true,
					nvim_cmp = true,
					nvim_bqf = true,
					nvim_dap = true,
					nvim_dap_ui = true,
					nvim_hlslens = true,
					nvim_lsp = true,
					nvim_navic = true,
					nvim_notify = true,
					nvim_tree = true,
					nvim_ts_rainbow = true,
					op_nvim = true,
					packer = true,
					persisted = true,
					polygot = true,
					rainbow_delimiters = true,
					render_markdown = true,
					startify = true,
					telescope = true,
					toggleterm = true,
					treesitter = true,
					trouble = true,
					vim_ultest = true,
					which_key = true,
					vim_dadbod_ui = true,
				},

				options = {
					cursorline = false, -- Use cursorline highlighting?
					transparency = true, -- Use a transparent background?
					terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
					lualine_transparency = false, -- Center bar transparency?
					highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
				},
			})
		end,
	},
}
