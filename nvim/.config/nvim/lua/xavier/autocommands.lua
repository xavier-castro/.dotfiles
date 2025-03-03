-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

-- Prefer creating groups and assigning autocmds to groups, because it makes it easier to clear them
augroup("mygroup", { clear = true })

autocmd({ "FileType" }, {
	pattern = { "markdown", "json" },
	callback = function()
		vim.wo.conceallevel = 0
	end,
	group = "mygroup",
})

local function search_by_directory(command_name, dir, prompt_title)
	usercmd(command_name, function()
		require("telescope.builtin").find_files({
			prompt_title = prompt_title,
			cwd = dir,
		})
	end, {})
end

local function grep_notes(command_name, dir, prompt_title)
	usercmd(command_name, function()
		require("telescope.builtin").live_grep({
			prompt_title = prompt_title,
			cwd = dir,
			glob_pattern = "*.md",
		})
	end, {})
end

-- Note lookup
search_by_directory("SearchNotes", "~/xcvault/notes/", "Search markdown notes")
grep_notes("GrepNotes", "~/xcvault/notes/", "Grep markdown files")
