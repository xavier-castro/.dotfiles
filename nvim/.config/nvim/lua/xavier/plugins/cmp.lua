return {
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		priority = 99,
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"rafamadriz/friendly-snippets",
			"tzachar/cmp-fuzzy-path",
			"tzachar/fuzzy.nvim",
		},

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})

			---Filter out unwanted entries
			---@return boolean
			local function entry_filter(entry, _)
				return not vim.tbl_contains({
					"No matches found",
					"Searching...",
					"Workspace loading",
				}, entry.completion_item.label)
			end

			---Filter out unwanted entries for fuzzy_path source
			local function entry_filter_fuzzy_path(entry, context)
				return entry_filter(entry, context)
					-- Don't show fuzzy-path entries in markdown/tex mathzone
					and not (
						vim.g.loaded_vimtex == 1
						and (vim.bo.ft == "markdown" or vim.bo.ft == "tex")
						and vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
					)
			end

			---Options for fuzzy_path source
			local fuzzy_path_option = {
				fd_cmd = {
					"fd",
					"-p",
					"-H",
					"-L",
					"-td",
					"-tf",
					"-tl",
					"-d4",
					"--mount",
					"-c=never",
					"-E=*$*",
					"-E=*%*",
					"-E=*.bkp",
					"-E=*.bz2",
					"-E=*.db",
					"-E=*.directory",
					"-E=*.dll",
					"-E=*.doc",
					"-E=*.docx",
					"-E=*.drawio",
					"-E=*.gif",
					"-E=*.git/",
					"-E=*.gz",
					"-E=*.ico",
					"-E=*.ipynb",
					"-E=*.iso",
					"-E=*.jar",
					"-E=*.jpeg",
					"-E=*.jpg",
					"-E=*.mp3",
					"-E=*.mp4",
					"-E=*.o",
					"-E=*.otf",
					"-E=*.out",
					"-E=*.pdf",
					"-E=*.pickle",
					"-E=*.png",
					"-E=*.ppt",
					"-E=*.pptx",
					"-E=*.pyc",
					"-E=*.rar",
					"-E=*.so",
					"-E=*.svg",
					"-E=*.tar",
					"-E=*.ttf",
					"-E=*.venv/",
					"-E=*.xls",
					"-E=*.xlsx",
					"-E=*.zip",
					"-E=*Cache*/",
					"-E=*\\~",
					"-E=*cache*/",
					"-E=.*Cache*/",
					"-E=.*cache*/",
					"-E=.*wine/",
					"-E=.cargo/",
					"-E=.conda/",
					"-E=.dot/",
					"-E=.fonts/",
					"-E=.ipython/",
					"-E=.java/",
					"-E=.jupyter/",
					"-E=.luarocks/",
					"-E=.mozilla/",
					"-E=.npm/",
					"-E=.nvm/",
					"-E=.steam*/",
					"-E=.thunderbird/",
					"-E=.tmp/",
					"-E=__pycache__/",
					"-E=dosdevices/",
					"-E=events.out.tfevents.*",
					"-E=node_modules/",
					"-E=vendor/",
					"-E=venv/",
				},
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<M-b>"] = cmp.mapping.scroll_docs(-4),
					["<M-f>"] = cmp.mapping.scroll_docs(4),
					["<C-f>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<Tab>"] = nil,
					["<S-Tab>"] = nil,
					["<C-a>"] = cmp.mapping(function(fallback)
						local suggestion = require("copilot.suggestion")
						if suggestion.is_visible() then
							suggestion.accept()
						elseif cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end, { "i", "c" }),
					["<C-j>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							vim.fn.feedkeys(
								vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
								""
							)
						else
							-- local suggestion = require("copilot.suggestion")
							-- if suggestion.is_visible() then
							-- 	suggestion.accept()
							-- local copilot_keys = vim.fn["copilot#Accept"]()
							-- if copilot_keys ~= "" then
							-- 	vim.api.nvim_feedkeys(copilot_keys, "i", true)
							-- else
							fallback()
							-- end
						end
					end,

					["<C-k>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							vim.fn.feedkeys(
								vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
								""
							)
						else
							fallback()
						end
					end,
				}),
				sources = {
					{ name = "luasnip", max_item_count = 3 },
					{ name = "nvim_lsp_signature_help" },
					{
						name = "fuzzy_path",
						entry_filter = entry_filter_fuzzy_path,
						option = fuzzy_path_option,
					},
					{
						name = "nvim_lsp",
						max_item_count = 20,
						entry_filter = entry_filter,
					},
					{ name = "nvim_lua" },
					{ name = "buffer", max_item_count = 8 },
				},
				window = {
					documentation = {
						max_width = 80,
						max_height = 20,
					},
				},
				performance = {
					max_view_entries = 64,
				},
			})
		end,
	},
}
