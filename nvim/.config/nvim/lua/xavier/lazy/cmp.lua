return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"roobert/tailwindcss-colorizer-cmp.nvim",
		"rafamadriz/friendly-snippets", -- snippets
		"brenoprata10/nvim-highlight-colors",
	},
	config = function()
		-- Ensure termguicolors is enabled if not already
		vim.opt.termguicolors = true
		require("nvim-highlight-colors").setup({
			enable_tailwind = true,
		})
		require("fidget").setup({})
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "luasnip" }, -- snippets
				{ name = "nvim_lsp" },
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "tailwindcss-colorizer-cmp" },
			}),
			---@diagnostic disable-next-line: missing-fields
			formatting = {
				format = require("nvim-highlight-colors").format,
			},
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "if_many",
				header = "",
				prefix = "",
			},
		})

		local config = require("cmp.config")
		local toggle_ghost_text = function()
			if vim.api.nvim_get_mode().mode ~= "i" then
				return
			end

			local cursor_column = vim.fn.col(".")
			local current_line_contents = vim.fn.getline(".")
			local character_after_cursor = current_line_contents:sub(cursor_column, cursor_column)

			local should_enable_ghost_text = character_after_cursor == ""
				or vim.fn.match(character_after_cursor, [[\k]]) == -1

			local current = config.get().experimental.ghost_text
			if current ~= should_enable_ghost_text then
				config.set_global({
					experimental = {
						ghost_text = should_enable_ghost_text,
					},
				})
			end
		end

		vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMovedI" }, {
			callback = toggle_ghost_text,
		})
	end,
}
