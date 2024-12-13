return {
	{
		"nomis51/nvim-xcode-theme",
		config = function()
			-- vim.cmd.colorscheme("xcode")
		end,
	},
	-- Rose Pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	-- Vim Colors Plain
	{
		"andreypopp/vim-colors-plain",
		config = function()
			-- vim.cmd.colorscheme("plain")
		end,
	},
	-- No Clown Fiesta
	{
		"aktersnurra/no-clown-fiesta.nvim",
		config = function()
			require("no-clown-fiesta").setup({
				transparent = true,
				styles = {
					-- You can set any of the style values specified for `:h nvim_set_hl`
					comments = {},
					keywords = {},
					functions = {},
					variables = {},
					type = { bold = false },
					lsp = { underline = false },
				},
			})
			-- vim.cmd.colorscheme("no-clown-fiesta")
		end,
	},
	-- VSCode
	{
		"Mofiqul/vscode.nvim",
		config = function()
			require("vscode").setup({
				transparent = true,
			})
			-- vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"andreasvc/vim-256noir",
		config = function()
			-- vim.cmd.colorscheme("256_noir")
		end,
	},
	-- Gruvbox
	{
		"luisiacc/gruvbox-baby",
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = true, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				color_overrides = {},
				custom_highlights = {},
				default_integrations = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			-- setup must be called before loading
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			-- Lua
			require("onedark").setup({
				-- Main options --
				style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				transparent = true, -- Show/hide background
				term_colors = true, -- Change terminal color as per the selected theme style
				ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
				cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

				-- toggle theme style ---
				toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
				toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

				-- Change code style ---
				-- Options are italic, bold, underline, none
				-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},

				-- Lualine options --
				lualine = {
					transparent = true, -- lualine center bar transparency
				},

				-- Custom Highlights --
				colors = {}, -- Override default colors
				highlights = {}, -- Override highlight groups

				-- Plugins Config --
				diagnostics = {
					darker = true, -- darker colors for diagnostic
					undercurl = true, -- use undercurl instead of underline for diagnostics
					background = true, -- use background color for virtual text
				},
			})
			-- vim.cmd.colorscheme("onedark")
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		config = function()
			-- Default options
			require("nightfox").setup({
				options = {
					-- Compiled file's destination location
					compile_path = vim.fn.stdpath("cache") .. "/nightfox",
					compile_file_suffix = "_compiled", -- Compiled file suffix
					transparent = true, -- Disable setting background
					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
					dim_inactive = false, -- Non focused panes set to alternative background
					module_default = true, -- Default enable value for modules
					colorblind = {
						enable = false, -- Enable colorblind support
						simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
						severity = {
							protan = 0, -- Severity [0,1] for protan (red)
							deutan = 0, -- Severity [0,1] for deutan (green)
							tritan = 0, -- Severity [0,1] for tritan (blue)
						},
					},
					styles = { -- Style to be applied to different syntax groups
						comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
						conditionals = "NONE",
						constants = "NONE",
						functions = "NONE",
						keywords = "NONE",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},
					inverse = { -- Inverse highlight for different types
						match_paren = false,
						visual = false,
						search = false,
					},
					modules = { -- List of various plugins and additional options
						-- ...
					},
				},
				palettes = {},
				specs = {},
				groups = {},
			})

			-- setup must be called before loading
			-- vim.cmd("colorscheme nightfox")
		end,
	},
	-- Lazy
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				transparent = true, -- don't set background
				style = {
					-- "none" is the same thing as default. But "italic" and "bold" are also valid options
					boolean = "none",
					number = "none",
					float = "none",
					error = "none",
					comments = "italic",
					conditionals = "none",
					functions = "none",
					headings = "bold",
					operators = "none",
					strings = "italic",
					variables = "none",

					-- keywords
					keywords = "none",
					keyword_return = "none",
					keywords_loop = "none",
					keywords_label = "none",
					keywords_exception = "none",

					-- builtin
					builtin_constants = "none",
					builtin_functions = "none",
					builtin_types = "none",
					builtin_variables = "none",
				},
				-- Override colors
				colors = {
					bg = "#18191a",
					fg = "#cdcdcd",
					floatBorder = "#878787",
					line = "#282830",
					comment = "#646477",
					builtin = "#bad1ce",
					func = "#be8c8c",
					string = "#deb896",
					number = "#d2a374",
					property = "#c7c7d4",
					constant = "#b4b4ce",
					parameter = "#b9a3ba",
					visual = "#363738",
					error = "#d2788c",
					warning = "#e6be8c",
					hint = "#8ca0dc",
					operator = "#96a3b2",
					keyword = "#7894ab",
					type = "#a1b3b9",
					search = "#465362",
					plus = "#8faf77",
					delta = "#e6be8c",
				},
			})
			-- vim.cmd.colorscheme("vague")
		end,
	},
}
