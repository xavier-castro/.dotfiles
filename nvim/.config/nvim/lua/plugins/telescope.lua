return {

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions

			local function telescope_buffer_dir()
				return vim.fn.expand("%:p:h")
			end

			-- load refactoring Telescope extension
			require("telescope").load_extension("refactoring")

			-- remap to open the Telescope refactoring menu in visual mode
			vim.api.nvim_set_keymap(
				"v",
				"<leader>rr",
				"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
				{ noremap = true }
			)

			telescope.setup({
				defaults = {
					mappings = {
						n = {
							["q"] = actions.close,
						},
					},
				},
				extensions = {
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
								["/"] = function()
									vim.cmd("startinsert")
								end,
							},
						},
					},
				},
			})
		end
	},
    { "ThePrimeagen/harpoon", config = function() require("harpoon").setup() 
    local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

    end },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "ThePrimeagen/refactoring.nvim" },
}
