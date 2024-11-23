return {
	---@class snacks.Config
	---@field bigfile? snacks.bigfile.Config | { enabled: boolean }
	---@field gitbrowse? snacks.gitbrowse.Config
	---@field lazygit? snacks.lazygit.Config
	---@field notifier? snacks.notifier.Config | { enabled: boolean }
	---@field quickfile? { enabled: boolean }
	---@field statuscolumn? snacks.statuscolumn.Config  | { enabled: boolean }
	---@field styles? table<string, snacks.win.Config>
	---@field dashboard? snacks.dashboard.Config  | { enabled: boolean }
	---@field terminal? snacks.terminal.Config
	---@field toggle? snacks.toggle.Config
	---@field win? snacks.win.Config
	---@field words? snacks.words.Config
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		dashboard = { enabled = true },
		bigfile = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
