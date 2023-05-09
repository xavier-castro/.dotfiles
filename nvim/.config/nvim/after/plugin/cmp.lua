if vim.g.vscode then
else
	local status, cmp = pcall(require, "cmp")
	if not status then
		return
	end
	local lspkind = require("lspkind")
	local function formatForTailwindCSS(entry, vim_item)
		if vim_item.kind == "Color" and entry.completion_item.documentation then
			local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
			if r then
				local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
				local group = "Tw_" .. color
				if vim.fn.hlID(group) < 1 then
					vim.api.nvim_set_hl(0, group, {
						fg = "#" .. color,
					})
				end
				vim_item.kind = "●"
				vim_item.kind_hl_group = group
				return vim_item
			end
		end
		vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
		return vim_item
	end
	(require("luasnip.loaders.from_lua")).lazy_load();
	(require("luasnip.loaders.from_vscode")).lazy_load();
	(require("luasnip.loaders.from_vscode")).load({
		paths = {
			"~/.dotfiles/nvim/.config/nvim/my-snippets",
		},
	});
	(require("luasnip.loaders.from_snipmate")).lazy_load({
		paths = {
			"~/.config/nvim/my_snippets",
		},
	})
	cmp.setup({
		snippet = {
			expand = function(args)
				(require("luasnip")).lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			-- ["<C-k>"] = cmp.mapping.select_prev_item(),
			-- ["<C-j>"] = cmp.mapping.select_next_item(),
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
			["<C-j>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
					)
				else
					local copilot_keys = vim.fn["copilot#Accept"]()
					if copilot_keys ~= "" then
						vim.api.nvim_feedkeys(copilot_keys, "i", true)
					else
						fallback()
					end
				end
			end,

			["<C-k>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
				else
					fallback()
				end
			end,
		}),
		sources = {
			{
				name = "nvim_lsp_signature_help",
				group_index = 1,
			},
			{
				name = "luasnip",
				max_item_count = 5,
				group_index = 1,
			},
			{
				name = "nvim_lsp",
				max_item_count = 20,
				group_index = 1,
			},
			{
				name = "nvim_lua",
				group_index = 1,
			},
			{
				name = "path",
				group_index = 2,
			},
			{
				name = "buffer",
				keyword_length = 2,
				max_item_count = 5,
				group_index = 2,
			},
		},
		formatting = {
			format = lspkind.cmp_format({
				maxwidth = 50,
				before = function(entry, vim_item)
					vim_item = formatForTailwindCSS(entry, vim_item)
					return vim_item
				end,
			}),
		},
	})
	vim.cmd("  set completeopt=menuone,noinsert,noselect\n  highlight! default link CmpItemKind CmpItemMenuDefault\n")
	vim.api.nvim_create_user_command("LuaSnipEdit", function()
		(require("luasnip.loaders")).edit_snippet_files({
			extend = function(ft, paths)
				if #paths == 0 then
					return {
						{
							"$CONFIG/" .. ft .. ".snippets",
							string.format("%s/%s.snippets", "~/.dotfiles/nvim/.config/nvim/my_snippets", ft),
						},
					}
				end
				return {}
			end,
		})
	end, {
		nargs = 0,
	})
end
