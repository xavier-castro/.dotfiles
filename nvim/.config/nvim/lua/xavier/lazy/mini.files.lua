return {
	"echasnovski/mini.files",
	version = false,
	config = function()
		local mini_files = require("mini.files")
		mini_files.setup({})
		-- Create keybind to use `mini_files.open()`
		vim.keymap.set("n", "-", function()
			local buf_name = vim.api.nvim_buf_get_name(0)
			local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
			mini_files.open(path)
			mini_files.reveal_cwd()
		end, { desc = "Open Mini Files" })
	end,
}
