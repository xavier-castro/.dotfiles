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
				preset = none, -- Disable preset to use custom keymaps
				["<M-b>"] = { "scroll_documentation_down" },
				["<M-f>"] = { "scroll_documentation_up" },
				["<C-f>"] = { "select_and_accept" },
				["<C-Space>"] = { "show" },
				["<C-e>"] = { "hide" },
				["<C-a>"] = { "accept", "fallback" },
				["<C-j>"] = { "select_next", "snippet_forward", "fallback" },
				["<C-k>"] = { "select_prev", "snippet_backward", "fallback" },
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
