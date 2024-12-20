-- lua/plugins/heirline.lua
return {
	"rebelot/heirline.nvim",
	event = "UiEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		-- Setup colors
		local colors = {
			bright_bg = utils.get_highlight("Folded").bg,
			bright_fg = utils.get_highlight("Folded").fg,
			red = utils.get_highlight("DiagnosticError").fg,
			dark_red = utils.get_highlight("DiffDelete").bg,
			green = utils.get_highlight("String").fg,
			blue = utils.get_highlight("Function").fg,
			gray = utils.get_highlight("NonText").fg,
			orange = utils.get_highlight("Constant").fg,
			purple = utils.get_highlight("Statement").fg,
			cyan = utils.get_highlight("Special").fg,
			diag_warn = utils.get_highlight("DiagnosticWarn").fg,
			diag_error = utils.get_highlight("DiagnosticError").fg,
			diag_hint = utils.get_highlight("DiagnosticHint").fg,
			diag_info = utils.get_highlight("DiagnosticInfo").fg,
			git_del = utils.get_highlight("diffDeleted").fg,
			git_add = utils.get_highlight("diffAdded").fg,
			git_change = utils.get_highlight("diffChanged").fg,
		}

		-- Vimode component
		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			static = {
				mode_names = {
					n = "NORMAL",
					no = "O-PENDING",
					nov = "O-PENDING",
					noV = "O-PENDING",
					["no\22"] = "O-PENDING",
					niI = "NORMAL",
					niR = "NORMAL",
					niV = "NORMAL",
					nt = "NORMAL",
					v = "VISUAL",
					vs = "VISUAL",
					V = "V-LINE",
					Vs = "V-LINE",
					["\22"] = "V-BLOCK",
					["\22s"] = "V-BLOCK",
					s = "SELECT",
					S = "S-LINE",
					["\19"] = "S-BLOCK",
					i = "INSERT",
					ic = "INSERT",
					ix = "INSERT",
					R = "REPLACE",
					Rc = "REPLACE",
					Rx = "REPLACE",
					Rv = "V-REPLACE",
					Rvc = "V-REPLACE",
					Rvx = "V-REPLACE",
					c = "COMMAND",
					cv = "EX",
					ce = "EX",
					r = "REPLACE",
					rm = "MORE",
					["r?"] = "CONFIRM",
					["!"] = "SHELL",
					t = "TERMINAL",
				},
				mode_colors = {
					n = "green",
					i = "red",
					v = "cyan",
					V = "cyan",
					["\22"] = "cyan",
					c = "orange",
					s = "purple",
					S = "purple",
					["\19"] = "purple",
					R = "orange",
					r = "orange",
					["!"] = "red",
					t = "red",
				},
			},
			provider = function(self)
				return " %2(" .. self.mode_names[self.mode] .. "%) "
			end,
			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { fg = "black", bg = colors[self.mode_colors[mode]], bold = true }
			end,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		-- File info component
		local FileInfo = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
			provider = function(self)
				local filename = vim.fn.fnamemodify(self.filename, ":t")
				if filename == "" then
					return "[No Name]"
				end
				return filename
			end,
			hl = { fg = colors.blue },
		}

		-- Git component
		local Git = {
			condition = conditions.is_git_repo,

			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,

			hl = { fg = colors.orange },

			{ -- git branch name
				provider = function(self)
					return " " .. self.status_dict.head
				end,
				hl = { bold = true },
			},
			{ -- git diff status
				provider = function(self)
					local parts = {
						{ text = "  " .. self.status_dict.added, fg = colors.git_add },
						{ text = "  " .. self.status_dict.removed, fg = colors.git_del },
						{ text = " 柳" .. self.status_dict.changed, fg = colors.git_change },
					}
					return table.concat(vim.tbl_map(function(part)
						return part.text
					end, parts))
				end,
				hl = { bold = true },
			},
		}

		-- Diagnostics component
		local Diagnostics = {
			condition = conditions.has_diagnostics,
			static = {
				error_icon = " ",
				warn_icon = " ",
				info_icon = " ",
				hint_icon = " ",
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { "DiagnosticChanged", "BufEnter" },
			{
				provider = function(self)
					return self.errors > 0 and (self.error_icon .. self.errors .. " ")
				end,
				hl = { fg = colors.diag_error },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
				end,
				hl = { fg = colors.diag_warn },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. " ")
				end,
				hl = { fg = colors.diag_info },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
				end,
				hl = { fg = colors.diag_hint },
			},
		}

		-- LSP component
		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },
			provider = function()
				local names = {}
				for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " " .. table.concat(names, " ")
			end,
			hl = { fg = colors.green, bold = true },
		}

		-- Ruler component
		local Ruler = {
			provider = "%7(%l/%3L%):%2c %P",
			hl = { fg = colors.blue, bold = true },
		}

		-- FileType component
		local FileType = {
			provider = function()
				return string.upper(vim.bo.filetype)
			end,
			hl = { fg = colors.blue, bold = true },
		}

		-- Align component
		local Align = { provider = "%=" }

		-- Space component
		local Space = { provider = " " }

		-- Setup statusline
		local StatusLine = {
			ViMode,
			Space,
			FileInfo,
			Space,
			Git,
			Space,
			Diagnostics,
			Align,
			LSPActive,
			Space,
			FileType,
			Space,
			Ruler,
		}

		require("heirline").setup({
			statusline = StatusLine,
			opts = {
				colors = colors,
			},
		})
	end,
}
