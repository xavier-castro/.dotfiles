return {
	"yetone/avante.nvim",
	event = "BufEnter",
	lazy = false,
	version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
	opts = {
		-- add any opts here
		-- for example
		provider = "claude",
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-3-7-sonnet-20250219",
			temperature = 0,
			max_tokens = 16000,
		},
		-- rag_service = {
		-- 	enabled = true,
		-- },
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",

			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
			enabled = true,
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-tree/nvim-web-devicons",
			},
			---@module 'render-markdown'
			-- ft = { "markdown", "norg", "rmd", "org" },
			init = function()
				-- Define colors
				local color1_bg = "#ff757f"
				local color2_bg = "#4fd6be"
				local color3_bg = "#7dcfff"
				local color4_bg = "#ff9e64"
				local color5_bg = "#7aa2f7"
				local color6_bg = "#c0caf5"
				local color_fg = "#1F2335"
				-- -- Heading background
				vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s gui=bold]], color_fg, color1_bg))
				vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s gui=bold]], color_fg, color2_bg))
				vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s gui=bold]], color_fg, color3_bg))
				vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s gui=bold]], color_fg, color4_bg))
				vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s gui=bold]], color_fg, color5_bg))
				vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s gui=bold]], color_fg, color6_bg))

				-- Heading fg
				-- vim.cmd(string.format([[highlight Headline1Fg guifg=%s gui=bold]], colors.color1_bg))
				-- vim.cmd(string.format([[highlight Headline2Fg guifg=%s gui=bold]], colors.color2_bg))
				-- vim.cmd(string.format([[highlight Headline3Fg guifg=%s gui=bold]], colors.color3_bg))
				-- vim.cmd(string.format([[highlight Headline4Fg guifg=%s gui=bold]], colors.color4_bg))
				-- vim.cmd(string.format([[highlight Headline5Fg guifg=%s gui=bold]], colors.color5_bg))
				-- vim.cmd(string.format([[highlight Headline6Fg guifg=%s gui=bold]], colors.color6_bg))
			end,
			opts = {
				heading = {
					sign = false,
					icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
					backgrounds = {
						"Headline1Bg",
						"Headline2Bg",
						"Headline3Bg",
						"Headline4Bg",
						"Headline5Bg",
						"Headline6Bg",
					},
					foregrounds = {
						"Headline1Fg",
						"Headline2Fg",
						"Headline3Fg",
						"Headline4Fg",
						"Headline5Fg",
						"Headline6Fg",
					},
				},
				code = {
					sign = false,
					width = "block",
					right_pad = 1,
				},
				bullet = {
					-- Turn on / off list bullet rendering
					enabled = true,
				},
				-- checkbox = {
				--     -- Turn on / off checkbox state rendering
				--     enabled = true,
				--     -- Determines how icons fill the available space:
				--     --  inline:  underlying text is concealed resulting in a left aligned icon
				--     --  overlay: result is left padded with spaces to hide any additional text
				--     position = "inline",
				--     unchecked = {
				--         -- Replaces '[ ]' of 'task_list_marker_unchecked'
				--         icon = "   󰄱 ",
				--         -- Highlight for the unchecked icon
				--         highlight = "RenderMarkdownUnchecked",
				--         -- Highlight for item associated with unchecked checkbox
				--         scope_highlight = nil,
				--     },
				--     checked = {
				--         -- Replaces '[x]' of 'task_list_marker_checked'
				--         icon = "   󰱒 ",
				--         -- Highlight for the checked icon
				--         highlight = "RenderMarkdownChecked",
				--         -- Highlight for item associated with checked checkbox
				--         scope_highlight = nil,
				--     },
				-- },
			},
		},
	},
}
