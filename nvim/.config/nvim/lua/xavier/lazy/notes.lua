return {
	"adibhanna/nvim-notes",
	dependencies = {
		"MunifTanjim/nui.nvim", -- Required for beautiful UI components
	},
	config = function()
		-- Your configuration here
		require("nvim-notes").setup({
			vault_path = "~/notes", -- Where to store notes
			auto_save = true, -- Auto-save notes on changes
			template = "# {{title}}\n\nCreated: {{date}} {{time}}\nTags: \n\n---\n\n",
			date_format = "%Y-%m-%d", -- Date format for new notes
			time_format = "%H:%M", -- Time format for templates
			preview_command = nil, -- Auto-detected (glow, mdcat, bat, cat)
			enable_concealing = true, -- Enable markdown concealing
			conceal_level = 2, -- Conceal level for markdown
			disable_default_keybindings = false, -- Disable default key mappings
			max_recent_notes = 10, -- Number of recent notes to show
		})
	end,
}
