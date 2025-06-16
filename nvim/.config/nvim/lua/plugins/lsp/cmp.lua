-- ===========================
-- Autocompletion
-- ===========================
return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
		{
			"saghen/blink.compat",
			version = "*",
			lazy = true,
			opts = {
				impersonate_nvim_cmp = false,
				debug = false,
			},
		},
		{
			"xzbdmw/colorful-menu.nvim",
			opts = {
				fallback_highlight = "@comment",
			},
		},
	},
	version = "1.*",
	build = "cargo build --release",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" } },
		appearance = {
			nerd_font_variant = "mono",
			use_nvim_cmp_as_default = true,
		},
		completion = {
			documentation = {
				auto_show_delay_ms = 500,
				auto_show = true,
				window = { border = "rounded" },
				treesitter_highlighting = true,
			},
			ghost_text = {
				show_with_selection = true,
				show_with_menu = true,
				show_without_menu = false,
				show_without_selection = false,
				enabled = true,
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
			menu = {
				auto_show = false,
				border = "rounded",
				-- mini icons text
				draw = {
					treesitter = { "lsp" },
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
					-- components = {
					-- 	kind_icon = {
					-- 		text = function(ctx)
					-- 			local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
					-- 			return kind_icon
					-- 		end,
					-- 		-- (optional) use highlights from mini.icons
					-- 		highlight = function(ctx)
					-- 			local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
					-- 			return hl
					-- 		end,
					-- 	},
					-- 	kind = {
					-- 		-- (optional) use highlights from mini.icons
					-- 		highlight = function(ctx)
					-- 			local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
					-- 			return hl
					-- 		end,
					-- 	},
					-- },
				},
			},
		},
		signature = { enabled = true, window = { border = "rounded" } },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				-- Dbee
				sql = { "dbee", "buffer" }, -- Add any other source to include here
			},
			providers = {
				dbee = { name = "cmp-dbee", module = "blink.compat.source" },
			},
		},
		fuzzy = { implementation = "rust" },
	},
	opts_extend = { "sources.default" },
	config = function(_, opts)
		require("blink.cmp").setup(opts)

		vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
	end,
}
