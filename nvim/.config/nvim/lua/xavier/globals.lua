function ColorMyPencils(color)
	color = color or "plain"
	vim.cmd("colorscheme " .. color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Define a command to call the ColorMyPencils function
vim.api.nvim_command("command! ColorMyPencils lua ColorMyPencils()")

function R(name)
	require("plenary.reload").reload_module(name)
end

local copilot_on = true
vim.api.nvim_create_user_command("CopilotToggle", function()
	if copilot_on then
		vim.cmd("Copilot disable")
		print("Copilot OFF")
	else
		vim.cmd("Copilot enable")
		print("Copilot ON")
	end
	copilot_on = not copilot_on
end, { nargs = 0 })
vim.keymap.set("", "<M-\\>", ":CopilotToggle<CR>", { noremap = true, silent = true })
