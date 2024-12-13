return {
	"numToStr/FTerm.nvim",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("FTerm").setup({
			blend = 5,
			dimensions = {
				height = 0.90,
				width = 0.90,
				x = 0.5,
				y = 0.5,
			},
		})
		-- Fterm
		vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('FTerm').toggle()<CR>", { noremap = true })
		vim.api.nvim_set_keymap("t", "<leader>tt", '<C-\\><C-n>:lua require("FTerm").toggle()<CR>', { noremap = true })

		-- Code Runner - execute commands in a floating terminal
		local runners = { lua = "lua", javascript = "node", python = "python3", py = "python3" }

		vim.keymap.set("n", "<leader>TT", function()
			local buf = vim.api.nvim_buf_get_name(0)
			local ftype = vim.filetype.match({ filename = buf })
			local exec = runners[ftype]
			if exec ~= nil then
				require("FTerm").scratch({ cmd = { exec, buf } })
			end
		end)
	end,
}
