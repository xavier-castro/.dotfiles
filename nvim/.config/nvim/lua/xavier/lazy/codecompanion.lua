vim.keymap.set({ "n", "v" }, "<C-b>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
vim.g.codecompanion_auto_tool_mode = true

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		display = {
			chat = {
				intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
				show_header_separator = true, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
				separator = "─", -- The separator between the different messages in the chat buffer
				show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
				show_settings = true, -- Show LLM settings at the top of the chat buffer?
				show_token_count = true, -- Show the token count for each response?
				start_in_insert_mode = false, -- Open the chat buffer in insert mode?
			},

			action_palette = {
				width = 95,
				height = 10,
				prompt = "Prompt ",              -- Prompt used for interactive LLM calls
				provider = "default",            -- Can be "default", "telescope", or "mini_pick". If not specified, the plugin will autodetect installed providers.
				opts = {
					show_default_actions = true,   -- Show the default actions in the action palette?
					show_default_prompt_library = true, -- Show the default prompt library in the action palette?
				},
			},
		},
		strategies = {
			inline = {
				keymaps = {
					accept_change = {
						modes = { n = "ga" },
						description = "Accept the suggested change",
					},
					reject_change = {
						modes = { n = "gr" },
						description = "Reject the suggested change",
					},
				},
			},
			-- Change the default chat adapter
			chat = {
				keymaps = {
					send = {
						modes = { n = "<C-s>", i = "<C-s>" },
					},
					close = {
						modes = { n = "<C-q>", i = "<C-q>" },
					},

				},
				adapter = "anthropic",
				tools = {
					["cmd_runner"] = {
						opts = {
							requires_approval = false,
						},
					},
					["mcp"] = {
						-- calling it in a function would prevent mcphub from being loaded before it's needed
						callback = function() return require("mcphub.extensions.codecompanion") end,
						description = "Call tools and resources from the MCP Servers",
					}
				}
			},
		},
		opts = {
			-- Set debug logging
			-- log_level = "DEBUG",
		},
	},
}
