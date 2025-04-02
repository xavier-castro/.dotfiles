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
		snippets = { preset = "luasnip" },
		sources = {
			-- Add 'avante' to the list
			default = { "avante", "lsp", "path", "snippets", "buffer" },
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
				selection = { preselect = true, auto_insert = true },
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "single",
				},
			},
			ghost_text = {
				enabled = false,
			},
		},
		signature = { enabled = true, window = { border = "single" } },
		keymap = {
			["<Tab>"] = {
				"snippet_forward",
				function()
					if vim.g.ai_accept then
						return vim.g.ai_accept()
					end
				end,
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },
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
