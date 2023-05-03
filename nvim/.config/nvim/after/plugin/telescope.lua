local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
	},
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown({}) },
		aerial = {
			-- Display symbols as <root>.<parent>.<symbol>
			show_nesting = {
				["_"] = false, -- This key will be the default
				json = true, -- You can set the option for specific filetypes
				yaml = true,
			},
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		file_browser = {
			theme = "dropdown",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					["<C-w>"] = function()
						vim.cmd("normal vbd")
					end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["M"] = fb_actions.move,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
	},
})
-- Load extensions after setup so they work
telescope.load_extension("file_browser")
telescope.load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("aerial")

-- Keybinds
vim.keymap.set("n", "<leader>cs", "<cmd>Telescope colorscheme<cr>", {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", ";o", builtin.oldfiles, {})
vim.keymap.set("n", ";f", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)
vim.keymap.set("n", ";r", function()
	builtin.registers({
		previewer = true,
	})
end)
vim.keymap.set("n", ";g", function()
	builtin.live_grep({
		search_dirs = { vim.fn.expand("%:p:h") },
	})
end)

vim.keymap.set("n", "\\\\", function()
	builtin.buffers()
end)
vim.keymap.set("n", ";h", function()
	builtin.help_tags()
end)
vim.keymap.set("n", ";j", function()
	builtin.jumplist()
end)
vim.keymap.set("n", ";t", "<cmd>TodoTelescope keywords=TODO,FIX,MARK<cr>", {})
vim.keymap.set("n", ";m", "<cmd>Telescope marks<cr>", {})
vim.keymap.set("n", "<M-e>", "<cmd>Telescope harpoon marks<cr>", {})
vim.keymap.set("n", "<leader><leader>f", "<cmd>Telescope current_buffer_fuzzy_find<cr>", {})

vim.keymap.set("n", ";;", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = {
			height = 40,
		},
	})
end)
