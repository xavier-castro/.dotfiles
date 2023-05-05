if vim.g.vscode then
else
	(require("nvim-treesitter.configs")).setup({
		ensure_installed = {
			"typescript",
			"javascript",
			"html",
			"tsx",
			"lua",
			"json",
			"rust",
			"css",
			"scss",
			"ruby",
			"rasi",
			"dockerfile",
			"bash",
			"c_sharp",
			"graphql",
			"vue",
			"svelte",
			"regex",
			"yaml",
			"go",
			"terraform",
			"vim",
			"markdown",
			"markdown_inline",
			"regex"
		},
		rainbow = {
			enable = true,
			extended_mode = false,
			max_file_lines = nil
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false
		},
		autotag = {
			enable = true
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = "<nop>",
				node_decremental = "<bs>"
			}
		}
	});
	local parser_config = (require("nvim-treesitter.parsers")).get_parser_configs();
	parser_config.tsx.filetype_to_parsername = {
		"javascript",
		"typescript.tsx"
	};
end;
