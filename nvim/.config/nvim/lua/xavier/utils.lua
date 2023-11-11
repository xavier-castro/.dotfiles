local M = {}

--- Get the first worktree that a file belongs to (from a predefined list of worktrees only)
--- Very useful for `.dotfiles` repository
---
--- Thanks AstroNvim!!
--- https://astronvim.com/Recipes/detached_git_worktrees
---
---@param file string? the file to check, defaults to the current file
---@param worktrees table<string, string>[]? an array like table of worktrees with entries `toplevel` and `gitdir`, default retrieves from `vim.g.git_worktrees`
---@return table<string, string>|nil # a table specifying the `toplevel` and `gitdir` of a worktree or nil if not found
function M.file_worktree(file, worktrees)
	worktrees = worktrees or vim.g.git_worktrees
	if not worktrees then
		return
	end
	file = file or vim.fn.resolve(vim.fn.expand("%"))

	if string.find(file, "neo-tree", 1, true) then
		-- Not valid file, use a directory
		file = vim.fn.fnamemodify(file, ":p:h")
	end

	for _, worktree in ipairs(worktrees) do
		if
		    M.cmd({
			    "git",
			    "--work-tree",
			    worktree.toplevel,
			    "--git-dir",
			    worktree.gitdir,
			    "ls-files",
			    "--error-unmatch",
			    file,
		    }, false)
		then
			return worktree
		end
	end
end

--- Run a shell command and capture the output and if the command succeeded or failed
---
--- Thanks AstroNvim!!
---
---@param cmd string|string[] The terminal command to execute
---@param show_error? boolean Whether or not to show an unsuccessful command as an error to the user
---@return string|nil # The result of a successfully executed command or nil
function M.cmd(cmd, show_error)
	if type(cmd) == "string" then
		cmd = { cmd }
	end
	if vim.fn.has("win32") == 1 then
		cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd)
	end
	local result = vim.fn.system(cmd)
	local success = vim.api.nvim_get_vvar("shell_error") == 0
	if not success and (show_error == nil or show_error) then
		vim.api.nvim_err_writeln(
			("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result)
		)
	end
	return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

--- Get the focused buffer filetype from a window id
--- @param winid number # The window id to get the filetype from
--- @return string filetype # The filetype of the focused buffer
function M.buf_filetype_from_winid(winid)
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local filetype = vim.bo[bufnr].filetype
	return filetype
end

--- Get the branch name with git-dir and worktree support
--- @param worktree table<string, string>|nil # a table specifying the `toplevel` and `gitdir` of a worktree
--- @param as_path string|nil # execute the git command from specific path
--- @return string branch # The branch name
function M.branch_name(worktree, as_path)
	local branch

	if worktree then
		branch = vim.fn.system(
			("git --git-dir=%s --work-tree=%s branch --show-current 2> /dev/null | tr -d '\n'"):format(
				worktree.gitdir,
				worktree.toplevel
			)
		)
	elseif as_path then
		branch = vim.fn.system(("git -C %s branch --show-current 2> /dev/null | tr -d '\n'"):format(as_path))
	else
		branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	end

	if branch ~= "" then
		return branch
	else
		return ""
	end
end

return M
