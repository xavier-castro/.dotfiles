return {
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = { enable = true },
			})
		end,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("solarized-osaka").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				transparent = true, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

				--- You can override specific color groups to use other groups or a hex color
				--- function will be called with a ColorScheme table
				---@param colors ColorScheme
				on_colors = function(colors) end,

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with a Highlights and ColorScheme table
				---@param highlights Highlights
				---@param colors ColorScheme
				on_highlights = function(highlights, colors) end,
			})
			vim.cmd.colorscheme("solarized-osaka")
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
				underline_links = true,
				disable_nvimtree_bg = false,
				terminal_colors = true,
				-- Override colors (see ./lua/vscode/colors.lua)
				color_overrides = {},
				-- Override highlight groups (see ./lua/vscode/theme.lua)
				group_overrides = {
					CopilotAnnotation = { fg = "#1F1F1F" },
					CopilotSuggestion = { fg = "#1F1F1F" },
					CopilotSelected = { fg = "#1F1F1F" },
					Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
					CursorLine = { bg = c.vscDarkBlue },
				},
			})
			-- vim.cmd.colorscheme("vscode")
			-- NOTE: Bufferline
			-- require("bufferline").setup({
			--   options = {
			--     buffer_close_icon = "",
			--     close_command = "bdelete %d",
			--     close_icon = "",
			--     indicator = {
			--       style = "icon",
			--       icon = " ",
			--     },
			--     left_trunc_marker = "",
			--     modified_icon = "●",
			--     offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
			--     right_mouse_command = "bdelete! %d",
			--     right_trunc_marker = "",
			--     show_close_icon = false,
			--     show_tab_indicators = true,
			--   },
			--   highlights = {
			--     fill = {
			--       fg = { attribute = "fg", highlight = "Normal" },
			--       bg = { attribute = "bg", highlight = "StatusLineNC" },
			--     },
			--     background = {
			--       fg = { attribute = "fg", highlight = "Normal" },
			--       bg = { attribute = "bg", highlight = "StatusLine" },
			--     },
			--     buffer_visible = {
			--       fg = { attribute = "fg", highlight = "Normal" },
			--       bg = { attribute = "bg", highlight = "Normal" },
			--     },
			--     buffer_selected = {
			--       fg = { attribute = "fg", highlight = "Normal" },
			--       bg = { attribute = "bg", highlight = "Normal" },
			--     },
			--     separator = {
			--       fg = { attribute = "bg", highlight = "Normal" },
			--       bg = { attribute = "bg", highlight = "StatusLine" },
			--     },
			--     separator_selected = {
			--       fg = { attribute = "fg", highlight = "Special" },
			--       bg = { attribute = "bg", highlight = "Normal" },
			--     },
			--     separator_visible = {
			--       fg = { attribute = "fg", highlight = "Normal" },
			--       bg = { attribute = "bg", highlight = "StatusLineNC" },
			--     },
			--     close_button = {
			--       fg = { attribute = "fg", highlight = "Normal" },
			--       bg = { attribute = "bg", highlight = "StatusLine" },
			--     },
			--     close_button_selected = {
			--       fg = { attribute = "fg", highlight = "Normal" },
			--       bg = { attribute = "bg", highlight = "Normal" },
			--     },
			--     close_button_visible = {
			--       fg = { attribute = "fg", highlight = "Normal" },
			--       bg = { attribute = "bg", highlight = "Normal" },
			--     },
			--   },
			-- })
		end,
	},
}

-- GHOSTTY COLORS
-- # vi: ft=conf :
--
-- # normal colors
-- palette = 0=#1F1F1F
-- palette = 1=#F44747
-- palette = 2=#6A9955
-- palette = 3=#DCDCAA
-- palette = 4=#569CD6
-- palette = 5=#C586C0
-- palette = 6=#56B6C2
-- palette = 7=#D4D4D4
--
-- # bright colors
-- palette = 8=#808080
-- palette = 9=#F44747
-- palette = 10=#6A9955
-- palette = 11=#DCDCAA
-- palette = 12=#569CD6
-- palette = 13=#C586C0
-- palette = 14=#56B6C2
-- palette = 15=#D4D4D4
--
-- background = #1F1F1F
-- foreground = #D4D4D4
-- cursor-color = #D4D4D4
--
-- selection-background = #264F78
-- selection-foreground = #ffffff
