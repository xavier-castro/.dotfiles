return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/snippets" } })
				end,
			},
		},
	},
	opts_extend = {
		"sources.completion.enabled_providers",
		"sources.compat",
		"sources.default",
	},
	enabled = function()
		return not vim.tbl_contains({ "AvanteInput", "minifiles" }, vim.bo.filetype)
			and vim.bo.buftype ~= "prompt"
			and vim.b.completion ~= false
	end,
	event = "InsertEnter",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				border = "single",
				draw = {
					columns = {
						{ "kind_icon", gap = 1 },
						{ "label", gap = 4 },
						{ "kind" },
						{ "label_description" },
					},

					gap = 1,
					treesitter = { "lsp" },
				},
			},
			list = {
				selection = { preselect = false, auto_insert = true },
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "single",
				},
			},
			ghost_text = {
				enabled = true,
			},
		},
		signature = { enabled = false, window = { border = "single" } },
		-- sources = {
		--   providers = {
		--     ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
		--     codecompanion = {
		--       name = "CodeCompanion",
		--       module = "codecompanion.providers.completion.blink",
		--     },
		--   },
		--   default = { "lsp", "path", "snippets", "buffer" },
		-- },
		--
		sources = {
			-- Add 'avante' to the list
			default = { "lsp", "path", "snippets", "buffer", "avante" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {
						-- options for blink-cmp-avante
					},
				},
			},
		},
		keymap = {
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
		},
	},
	appearance = {
		kind_icons = {
			Text = "󰉿",
			Method = "",
			Function = "󰊕",
			Constructor = "󰒓",
			Field = "",
			Variable = "󰆦",
			Property = "󰖷",
			Class = "",
			Interface = "",
			Struct = "󱡠",
			Module = "󰅩",
			Unit = "󰪚",
			Value = "󰫧",
			Enum = "",
			EnumMember = "",
			Keyword = "",
			Constant = "󰏿",
			Snippet = "󱄽",
			Color = "󰏘",
			File = "󰈔",
			Reference = "󰬲",
			Folder = "󰉋",
			Event = "󱐋",
			Operator = "󰪚",
			TypeParameter = "󰬛",
			Error = "󰏭",
			Warning = "",
			Information = "󰋼",
			Hint = "",
		},
	},
	keymap = {
		preset = "default",
		["<C-y>"] = { "select_and_accept" },
	},
}
