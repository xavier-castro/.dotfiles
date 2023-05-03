return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	init = function()
		local r = require("xavier.utils.remaps")

		r.noremap("n", "-", "<cmd>Neotree reveal<CR>", "Toggle explorer")
	end,
	config = {
		sources = {
			"filesystem",
			"buffers",
			"git_status",
		},
		enable_git_status = false,
		window = {
			-- position = "current",
			mappings = { ["-"] = "close_window", ["/"] = "noop" },
			["e"] = function()
				vim.api.nvim_exec("Neotree focus filesystem left", true)
			end,
			["b"] = function()
				vim.api.nvim_exec("Neotree focus buffers left", true)
			end,
			["g"] = function()
				vim.api.nvim_exec("Neotree focus git_status left", true)
			end,
			["o"] = "system_open",
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
