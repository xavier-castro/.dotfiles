return {
    {
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = {
				TelescopePrompt = false,
			}
			vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<C-a>", "copilot#Accept()", "Accepts copilot suggestion", {
				script = true,
				expr = true,
				silent = true,
			})
			vim.keymap.set("i", "<C-x>", "copilot#Dismiss()", "Dismisses copilot suggestion", {
				script = true,
				expr = true,
				silent = true,
			})
			vim.keymap.set({ "i", "n" }, "<M-p>", ":Copilot panel<cr>")
		end,
	},
}