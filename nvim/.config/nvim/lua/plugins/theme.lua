---@diagnostic disable: undefined-global
return {
	{
		"no-clown-fiesta/no-clown-fiesta.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd([[colorscheme no-clown-fiesta]])
			vim.cmd.colorscheme(color)
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
	{ "tjdevries/colorbuddy.nvim" },
	{
		"svrana/neosolarized.nvim",
		config = function()
			local n = require("neosolarized")

			n.setup({
				comment_italics = true,
			})

			local cb = require("colorbuddy.init")
			local Color = cb.Color
			local colors = cb.colors
			local Group = cb.Group
			local groups = cb.groups
			local styles = cb.styles

			Color.new("white", "#ffffff")
			Color.new("black", "#000000")
			Group.new("Normal", colors.base1, colors.NONE, styles.NONE)
			Group.new("CursorLine", colors.none, colors.base03, styles.NONE, colors.base1)
			Group.new("CursorLineNr", colors.yellow, colors.black, styles.NONE, colors.base1)
			Group.new("Visual", colors.none, colors.base03, styles.reverse)

			local cError = groups.Error.fg
			local cInfo = groups.Information.fg
			local cWarn = groups.Warning.fg
			local cHint = groups.Hint.fg

			Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
			Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
			Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
			Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
			Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
			Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
			Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
			Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)
			Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
			})
		end,
	},
}
