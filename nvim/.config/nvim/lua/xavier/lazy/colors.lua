function ColorMyPencils(color)
	color = color or "vscode"
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
}
