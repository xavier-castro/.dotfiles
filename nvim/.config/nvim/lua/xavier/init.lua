-- Xavier's Neovim Configuration

-- Core configuration
require("xavier.set") -- Basic settings
require("xavier.remap") -- Key remappings
require("xavier.lazy_init") -- Plugin manager initialization

-- Helper function for module reloading during development
function R(name)
	require("plenary.reload").reload_module(name)
end

-- Create autocommand groups
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local XavierGroup = augroup("Xavier", {})
local yank_group = augroup("HighlightYank", {})

-- File type associations
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

-- Terminal configuration
-- Disable line numbers in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

-- Terminal escape mapping
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Split terminal functionality
local job_id = 0
vim.keymap.set("n", "<space>to", function() -- Open terminal in split
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 5)
	job_id = vim.bo.channel
end)

-- Terminal command execution
local current_command = ""
vim.keymap.set("n", "<space>te", function() -- Enter command
	current_command = vim.fn.input("Command: ")
end)

vim.keymap.set("n", "<space>tr", function() -- Run command
	if current_command == "" then
		current_command = vim.fn.input("Command: ")
	end
	vim.fn.chansend(job_id, { current_command .. "\r\n" })
end)

-- Floating terminal implementation
local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	-- Calculate the position to center the window
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal", -- No borders or extra UI elements
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set("n", "<M-F>", toggle_terminal)

-- Autocommands
-- Highlight yanked text
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- Remove trailing whitespace on save
autocmd({ "BufWritePre" }, {
	group = XavierGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})
-- LSP keybindings
autocmd("LspAttach", {
	group = XavierGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

-- Netrw (file explorer) settings
-- vim.g.netrw_browse_split = 0 -- Open files in the same window
-- vim.g.netrw_banner = 0 -- Hide the banner
-- vim.g.netrw_winsize = 25 -- Set the width to 25% of the screen

-- This is to keep a persistent theme
require("current-theme")
