-- lua/plugins/cmp.lua
return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"rafamadriz/friendly-snippets",
		},
		version = "v0.*",
		opts = {
			keymap = {
				preset = "enter",
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"codecompanion",
				},
				providers = {
					codecompanion = {
						name = "CodeCompanion",
						module = "codecompanion.providers.completion.blink",
						enabled = true,
					},
				},
			},
		},
	},
}
