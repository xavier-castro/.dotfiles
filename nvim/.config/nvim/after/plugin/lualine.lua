local status, lualine = pcall(require, "lualine")
if not status then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "solarized_dark",
		section_separators = {
			left = "",
			right = "",
		},
		component_separators = {
			left = "",
			right = "",
		},
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
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
			"encoding",
			"filetype",
		},
		lualine_y = {
			{
				"aerial",
				-- The separator to be used to separate symbols in status line.
				sep = " ) ",

				-- The number of symbols to render top-down. In order to render only 'N' last
				-- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
				-- be used in order to render only current symbol.
				depth = nil,

				-- When 'dense' mode is on, icons are not rendered near their symbols. Only
				-- a single icon that represents the kind of current symbol is rendered at
				-- the beginning of status line.
				dense = false,

				-- The separator to be used to separate symbols in dense mode.
				dense_sep = ".",

				-- Color the symbol icons.
				colored = true,
			},
		},
		lualine_z = {
			"location",
		},
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
