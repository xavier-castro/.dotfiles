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
			vim.cmd.colorscheme("vscode")
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
