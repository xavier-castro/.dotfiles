return {
    {
		"nvim-neorg/neorg",
		ft = "norg", -- lazy load on filetype
		cmd = "Neorg", -- lazy load on command, allows you to autocomplete :Neorg regardless of whether it's loaded yet
		--  (you could also just remove both lazy loading things)
		priority = 30, -- treesitter is on default priority of 50, neorg should load after it.
		build = ":Neorg sync-parsers",
		lazy = false,
		config = function()
			require("neorg").setup({

				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {
						config = {
							icon_preset = "diamond",
						},
					}, -- Adds pretty icons to your documents
					-- Required for export markdown
					["core.integrations.treesitter"] = {},
					["core.export.markdown"] = {},
					["core.export"] = {},
					["core.summary"] = {},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								main = "~/neorg/main",
								school = "~/neorg/school",
								projects = "~/neorg/projects",
								notepad = "~/neorg/notepad",
							},
							default_workspace = "main",
						},
					},
				},
			})
			-- Neorg
			vim.keymap.set("n", "<LocalLeader>r", "<cmd>Neorg return<cr>")
			vim.keymap.set("n", "<LocalLeader>gw", "<cmd>Neorg workspace<cr>")
			vim.keymap.set("n", "<LocalLeader>gg", "<cmd>Neorg workspace notepad<cr>")
			vim.keymap.set("n", "<LocalLeader>gj", "<cmd>Neorg journal<cr>")
			vim.keymap.set("n", "<LocalLeader>gi", "<cmd>Neorg index<cr>")
			vim.keymap.set("n", "<LocalLeader>cc", "<cmd>Neorg toggle-concealer<cr>")
		end,
		dependencies = { { "nvim-lua/plenary.nvim" } },
	}
}