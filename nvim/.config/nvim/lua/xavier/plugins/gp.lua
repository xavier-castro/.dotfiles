return {
    {
		"robitx/gp.nvim",
		config = function()
			local openai_api_key = vim.fn.getenv("OPENAI_API_KEY")
			require("gp").setup({
				openai_api_key = openai_api_key,
				hooks = {
					InspectPlugin = function(plugin, params)
						local bufnr = vim.api.nvim_create_buf(false, true)
						local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(plugin))
						local params_info = string.format("Command params:\n%s", vim.inspect(params))
						local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
						vim.api.nvim_win_set_buf(0, bufnr)
					end,

					-- GpImplement rewrites the provided selection/range based on comments in it
					Implement = function(gp, params)
						local template = "Having following from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please rewrite this according to the contained instructions."
							.. "\n\nRespond exclusively with the snippet that should replace the selection above."

						local agent = gp.get_command_agent()
						gp.Info("Implementing selection with agent: " .. agent.name)

						gp.Prompt(
							params,
							gp.Target.rewrite,
							nil, -- command will run directly without any prompting for user input
							agent.model,
							template,
							agent.system_prompt
						)
					end,

					-- your own functions can go here, see README for more examples like
					-- :GpExplain, :GpUnitTests.., :GpTranslator etc.

					-- example of making :%GpChatNew a dedicated command which
					-- opens new chat with the entire current buffer as a context
					BufferChatNew = function(gp, _)
						-- call GpChatNew command in range mode on whole buffer
						vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
					end,

					-- -- example of adding command which opens new chat dedicated for translation
					-- Translator = function(gp, params)
					-- 	local agent = gp.get_command_agent()
					-- 	local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
					-- 	gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
					-- end,

					-- -- example of adding command which writes unit tests for the selected code
					-- UnitTests = function(gp, params)
					-- 	local template = "I have the following code from {{filename}}:\n\n"
					-- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
					-- 		.. "Please respond by writing table driven unit tests for the code above."
					-- 	local agent = gp.get_command_agent()
					-- 	gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
					-- end,

					-- example of adding command which explains the selected code
					Explain = function(gp, params)
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please respond by explaining the code above."
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
					end,
				},
			})
			-- VISUAL mode mappings
			-- s, x, v modes are handled the same way by which_key
			require("which-key").register({
				-- ...
				["<C-g>"] = {
					c = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
					v = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
					t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat" },

					["<C-x>"] = { ":'<,'>GpChatNew split<CR>", "Visual Chat New split" },
					["<C-v>"] = { ":'<,'>GpChatNew vsplit<CR>", "Visual Chat New vsplit" },
					["<C-t>"] = { ":'<,'>GpChatNew tabnew<CR>", "Visual Chat New tabnew" },

					r = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
					a = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append" },
					b = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend" },
					e = { ":<C-u>'<,'>GpEnew<cr>", "Visual Enew" },
					p = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },

					x = { ":<C-u>'<,'>GpContext<cr>", "Visual Toggle Context" },

					n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
					s = { "<cmd>GpStop<cr>", "Stop" },

					-- optional Whisper commands
					w = { ":<C-u>'<,'>GpWhisper<cr>", "Whisper" },
					R = { ":<C-u>'<,'>GpWhisperRewrite<cr>", "Whisper Visual Rewrite" },
					A = { ":<C-u>'<,'>GpWhisperAppend<cr>", "Whisper Visual Append" },
					B = { ":<C-u>'<,'>GpWhisperPrepend<cr>", "Whisper Visual Prepend" },
					E = { ":<C-u>'<,'>GpWhisperEnew<cr>", "Whisper Visual Enew" },
					P = { ":<C-u>'<,'>GpWhisperPopup<cr>", "Whisper Visual Popup" },
				},
				-- ...
			}, {
				mode = "v", -- VISUAL mode
				prefix = "",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = true,
			})

			-- NORMAL mode mappings
			require("which-key").register({
				-- ...
				["<C-g>"] = {
					c = { "<cmd>GpChatNew<cr>", "New Chat" },
					t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
					f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

					["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
					["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
					["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

					r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
					a = { "<cmd>GpAppend<cr>", "Append" },
					b = { "<cmd>GpPrepend<cr>", "Prepend" },
					e = { "<cmd>GpEnew<cr>", "Enew" },
					p = { "<cmd>GpPopup<cr>", "Popup" },

					x = { "<cmd>GpContext<cr>", "Toggle Context" },
					n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
					s = { "<cmd>GpStop<cr>", "Stop" },

					-- optional Whisper commands
					w = { "<cmd>GpWhisper<cr>", "Whisper" },
					R = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
					A = { "<cmd>GpWhisperAppend<cr>", "Whisper Append" },
					B = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend" },
					E = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
					P = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
				},
				-- ...
			}, {
				mode = "n", -- NORMAL mode
				prefix = "",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = true,
			})

			-- INSERT mode mappings
			require("which-key").register({
				-- ...
				["<C-g>"] = {
					c = { "<cmd>GpChatNew<cr>", "New Chat" },
					t = { "<cmd>GpChatToggle<cr>", "Toggle Popup Chat" },
					f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

					["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
					["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
					["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

					r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
					a = { "<cmd>GpAppend<cr>", "Append" },
					b = { "<cmd>GpPrepend<cr>", "Prepend" },
					e = { "<cmd>GpEnew<cr>", "Enew" },
					p = { "<cmd>GpPopup<cr>", "Popup" },

					x = { "<cmd>GpContext<cr>", "Toggle Context" },
					n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
					s = { "<cmd>GpStop<cr>", "Stop" },

					-- optional Whisper commands
					w = { "<cmd>GpWhisper<cr>", "Whisper" },
					R = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
					A = { "<cmd>GpWhisperAppend<cr>", "Whisper Append" },
					B = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend" },
					E = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
					P = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
				},
				-- ...
			}, {
				mode = "i", -- INSERT mode
				prefix = "",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = true,
			})

		end,
	},
}
