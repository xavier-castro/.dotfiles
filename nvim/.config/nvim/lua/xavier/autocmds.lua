local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local namespace = vim.api.nvim_create_namespace
local utils = require("xavier.utils")
local events = require("xavier.events")

local is_available = utils.is_available
local MAX_WIN_HISTORY_LENGTH = 4
local general = augroup("General Settings", { clear = true })

--- Keep track of valid window ids in a variable.
---
--- Thanks!
--- https://www.reddit.com/r/neovim/comments/szjysg/comment/hyli78a/?utm_source=share&utm_medium=web2x&context=3
autocmd({ "WinEnter", "VimEnter" }, {
	callback = function(_)
		-- Exclude floating windows
		if "" ~= vim.api.nvim_win_get_config(0).relative then
			return
		end

		local ignored_filetypes = { "DressingInput", "neo-tree" }
		local ignored_buftypes = { "nofile" }

		if vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
			return
		end

		if vim.tbl_contains(ignored_buftypes, vim.bo.buftype) then
			return
		end

		local current_win_id = vim.fn.win_getid()

		-- Initialize if not present
		if vim.t.win_history == nil then
			vim.t.win_history = { current_win_id }
		end

		local history = vim.t.win_history

		-- `history[1]` will be our previous window, we don't want to
		-- duplicate it in our history at the 1 position
		if history[1] == current_win_id then
			return
		end

		-- Restrict lenght of history
		if #vim.t.win_history >= MAX_WIN_HISTORY_LENGTH then
			table.remove(history)
		end

		-- Remove any invalid window id
		for _, history_win_id in ipairs(history) do
			if not vim.api.nvim_win_is_valid(history_win_id) then
				table.remove(history)
				break
			end
		end

		-- Insert new window id to the beginning of the history
		table.insert(history, 1, current_win_id)

		vim.t.win_history = history
	end,
})

--- This adds support for worktrees in gitsigns.nvim
--- Thanks AstroNvim!!
autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
	group = augroup("file_user_events", { clear = true }),
	callback = function(args)
		local current_file = vim.fn.resolve(vim.fn.expand("%"))

		if not (current_file == "" or vim.api.nvim_get_option_value("buftype", { buf = args.buf }) == "nofile") then
			events.event("File")

			local worktree = utils.file_worktree()

			if worktree or utils.cmd({ "git", "-C", vim.fn.fnamemodify(current_file, ":p:h"), "rev-parse" }, false) then
				events.event("GitFile")
				vim.api.nvim_del_augroup_by_name("file_user_events")
			end
		end
	end,
})

--- Disable automatic comment on next line
autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	group = general,
	desc = "Disable New Line Comment",
})
