return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	cmd = "Neotree",
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				-- only needed if you want to use the commands with "_with_window_picker" suffix
				"s1n7ax/nvim-window-picker",
				config = function()
					require("window-picker").setup({
						autoselect_one = true,
						include_current = false,
						filter_rules = {
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },

								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
						other_win_hl_color = "#e35e4f",
					})
				end,
			},
		},
	},
	init = function()
		local r = require("xavier.utils.remaps")

		r.noremap("n", "<leader>e", "<cmd>Neotree show<CR>", "Toggle explorer")
	end,
	config = {
		source_selector = {
			winbar = true,
			statusline = false,
		},
		sources = {
			"filesystem",
			"buffers",
			"git_status",
		},
		enable_git_status = false,
		window = {
			position = "left",
			width = 35,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<space>"] = {
					"toggle_node",
					nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
				},
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["<esc>"] = "revert_preview",
				["P"] = { "toggle_preview", config = { use_float = true } },
				["l"] = "focus_preview",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				-- ["S"] = "split_with_window_picker",
				-- ["s"] = "vsplit_with_window_picker",
				["t"] = "open_tabnew",
				-- ["<cr>"] = "open_drop",
				-- ["t"] = "open_tab_drop",
				["w"] = "open_with_window_picker",
				--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
				["C"] = "close_node",
				-- ['C'] = 'close_all_subnodes',
				["z"] = "close_all_nodes",
				--["Z"] = "expand_all_nodes",
				["N"] = {
					"add",
					-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = "none", -- "none", "relative", "absolute"
					},
				},
				["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
				-- ["c"] = {
				--  "copy",
				--  config = {
				--    show_path = "none" -- "none", "relative", "absolute"
				--  }
				--}
				["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
			},
		},
		commands = {
			system_open = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				-- macOs: open file in default application in the background.
				-- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
				vim.api.nvim_command("silent !open -g " .. path)
				-- Linux: open file in default application
				vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
			end,
		},
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = true,
			components = {
				harpoon_index = function(config, node, state)
					local Marked = require("harpoon.mark")
					local path = node:get_id()
					local succuss, index = pcall(Marked.get_index_of, path)
					if succuss and index and index > 0 then
						return {
							text = string.format(" ⥤ %d", index), -- <-- Add your favorite harpoon like arrow here
							highlight = config.highlight or "NeoTreeDirectoryIcon",
						}
					else
						return {}
					end
				end,
			},
			renderers = {
				file = {
					{ "icon" },
					{ "name", use_git_status_colors = true },
					{ "harpoon_index" }, --> This is what actually adds the component in where you want it
					{ "diagnostics" },
					{ "git_status", highlight = "NeoTreeDimText" },
				},
			},
		},
	},
}
