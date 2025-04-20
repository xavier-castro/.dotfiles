return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	keys = {
		{
			"<leader>ip",
			function()
				return vim.bo.filetype == "AvanteInput" and require("avante.clipboard").paste_image()
					or require("img-clip").paste_image()
			end,
			desc = "clip: paste image",
		},
	},
	opts = {
		hints = { enabled = false },

		behaviour = {
			auto_suggestions = false, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = true,
			minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
			enable_token_counting = true, -- Whether to enable token counting. Default to true.
			enable_cursor_planning_mode = true, -- Whether to enable Cursor Planning Mode. Default to false.
			enable_claude_text_editor_tool_mode = true, -- Whether to enable Claude Text Editor Tool Mode.
		},
		-- other config
		-- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
		system_prompt = function()
			local hub = require("mcphub").get_hub_instance()
			return hub:get_active_servers_prompt()
		end,
		-- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
		custom_tools = function()
			return {
				require("mcphub.extensions.avante").mcp_tool(),
			}
		end,
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
	},
	config = function()
		-- prefil edit window with common scenarios to avoid repeating query and submit immediately
		local prefill_edit_window = function(request)
			require("avante.api").edit()
			local code_bufnr = vim.api.nvim_get_current_buf()
			local code_winid = vim.api.nvim_get_current_win()
			if code_bufnr == nil or code_winid == nil then
				return
			end
			vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
			-- Optionally set the cursor position to the end of the input
			vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
			-- Simulate Ctrl+S keypress to submit
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
		end

		-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
		local avante_grammar_correction =
			"Correct the text to standard English, but keep any code blocks inside intact."
		local avante_keywords = "Extract the main keywords from the following text"
		local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
		local avante_optimize_code = "Optimize the following code"
		local avante_summarize = "Summarize the following text"
		local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
		local avante_explain_code = "Explain the following code"
		local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
		local avante_add_docstring = "Add docstring to the following codes"
		local avante_fix_bugs = "Fix the bugs inside the following codes if any"
		local avante_add_tests = "Implement tests for the following code"

		require("which-key").add({
			{ "<leader>a", group = "Avante" }, -- NOTE: add for avante.nvim
			{
				mode = { "n", "v" },
				{
					"<leader>ag",
					function()
						require("avante.api").ask({ question = avante_grammar_correction })
					end,
					desc = "Grammar Correction(ask)",
				},
				{
					"<leader>ak",
					function()
						require("avante.api").ask({ question = avante_keywords })
					end,
					desc = "Keywords(ask)",
				},
				{
					"<leader>al",
					function()
						require("avante.api").ask({ question = avante_code_readability_analysis })
					end,
					desc = "Code Readability Analysis(ask)",
				},
				{
					"<leader>ao",
					function()
						require("avante.api").ask({ question = avante_optimize_code })
					end,
					desc = "Optimize Code(ask)",
				},
				{
					"<leader>am",
					function()
						require("avante.api").ask({ question = avante_summarize })
					end,
					desc = "Summarize text(ask)",
				},
				{
					"<leader>an",
					function()
						require("avante.api").ask({ question = avante_translate })
					end,
					desc = "Translate text(ask)",
				},
				{
					"<leader>ax",
					function()
						require("avante.api").ask({ question = avante_explain_code })
					end,
					desc = "Explain Code(ask)",
				},
				{
					"<leader>ac",
					function()
						require("avante.api").ask({ question = avante_complete_code })
					end,
					desc = "Complete Code(ask)",
				},
				{
					"<leader>ad",
					function()
						require("avante.api").ask({ question = avante_add_docstring })
					end,
					desc = "Docstring(ask)",
				},
				{
					"<leader>ab",
					function()
						require("avante.api").ask({ question = avante_fix_bugs })
					end,
					desc = "Fix Bugs(ask)",
				},
				{
					"<leader>au",
					function()
						require("avante.api").ask({ question = avante_add_tests })
					end,
					desc = "Add Tests(ask)",
				},
			},
		})

		require("which-key").add({
			{ "<leader>a", group = "Avante" }, -- NOTE: add for avante.nvim
			{
				mode = { "v" },
				{
					"<leader>aG",
					function()
						prefill_edit_window(avante_grammar_correction)
					end,
					desc = "Grammar Correction",
				},
				{
					"<leader>aK",
					function()
						prefill_edit_window(avante_keywords)
					end,
					desc = "Keywords",
				},
				{
					"<leader>aO",
					function()
						prefill_edit_window(avante_optimize_code)
					end,
					desc = "Optimize Code(edit)",
				},
				{
					"<leader>aC",
					function()
						prefill_edit_window(avante_complete_code)
					end,
					desc = "Complete Code(edit)",
				},
				{
					"<leader>aD",
					function()
						prefill_edit_window(avante_add_docstring)
					end,
					desc = "Docstring(edit)",
				},
				{
					"<leader>aB",
					function()
						prefill_edit_window(avante_fix_bugs)
					end,
					desc = "Fix Bugs(edit)",
				},
				{
					"<leader>aU",
					function()
						prefill_edit_window(avante_add_tests)
					end,
					desc = "Add Tests(edit)",
				},
			},
		})
	end,
}
