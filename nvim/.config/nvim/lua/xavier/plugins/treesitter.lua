return {
	-- MDX syntax
	{ "jxnblk/vim-mdx-js" },
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/playground",
		},
		build = ":TSUpdate",
		config = function()
			-- [[ Configure Treesitter ]]
			-- See `:help nvim-treesitter`
			-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
			vim.defer_fn(function()
				require("nvim-treesitter.configs").setup({
					-- Add languages to be installed here that you want installed for treesitter
					ensure_installed = {
						"c",
						"cpp",
						"go",
						"lua",
						"python",
						"rust",
						"tsx",
						"javascript",
						"typescript",
						"vimdoc",
						"vim",
						"bash",
					},

					-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
					auto_install = true,
					highlight = { enable = false },
					indent = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "<c-space>",
							node_incremental = "<c-space>",
							scope_incremental = "<c-s>",
							node_decremental = "<M-space>",
						},
					},
					textobjects = {
						select = {
							enable = true,
							lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
							keymaps = {
								-- You can use the capture groups defined in textobjects.scm
								["aa"] = "@parameter.outer",
								["ia"] = "@parameter.inner",
								["af"] = "@function.outer",
								["if"] = "@function.inner",
								["ac"] = "@class.outer",
								["ic"] = "@class.inner",
							},
						},
						move = {
							enable = true,
							set_jumps = true, -- whether to set jumps in the jumplist
							goto_next_start = {
								["]m"] = "@function.outer",
								["]]"] = "@class.outer",
							},
							goto_next_end = {
								["]M"] = "@function.outer",
								["]["] = "@class.outer",
							},
							goto_previous_start = {
								["[m"] = "@function.outer",
								["[["] = "@class.outer",
							},
							goto_previous_end = {
								["[M"] = "@function.outer",
								["[]"] = "@class.outer",
							},
						},
						swap = {
							enable = true,
							swap_next = {
								["<leader>a"] = "@parameter.inner",
							},
							swap_previous = {
								["<leader>A"] = "@parameter.inner",
							},
						},
						autotag = {
							enable = true,
							enable_rename = true,
							enable_close = true,
							enable_close_on_slash = false,
						},
						context_commentstring = {
							enable = true,
							enable_autocmd = false,
						},
					},
				})
				local parser_config = (require("nvim-treesitter.parsers")).get_parser_configs()
				parser_config.tsx.filetype_to_parsername = {
					"javascript",
					"typescript.tsx",
				}
				parser_config.norg = {
					install_info = {
						url = "https://github.com/vhyrro/tree-sitter-norg",
						files = { "src/parser.c" },
						branch = "main",
					},
				}

				require("treesitter-context").setup({
					enable = false,
				})
				vim.keymap.set("n", "<leader>tsc", "<cmd>TSCaptureUnderCursor<cr>")
				vim.keymap.set("n", "<leader>tsp", "<cmd>TSPlaygroundToggle<cr>")
			end, 0)
		end,
	},
}
