local searcher = "xavier" --- "fzf-lua" | "Xavier"
if searcher == "xavier" then
	vim.opt.grepprg = "rg --vimgrep --smart-case"
	vim.keymap.set("n", "<leader>/", function()
		local pattern = vim.fn.input("rg: ")
		if pattern ~= "" then
			vim.cmd('silent grep! "' .. pattern .. '"')
			vim.cmd("copen")
		end
	end, { desc = "xavier: Live grep" })

	function Fd(file_pattern, _)
		-- if first char is * then fuzzy search
		if file_pattern:sub(1, 1) == "*" then
			file_pattern = file_pattern:gsub(".", ".*%0") .. ".*"
		end
		local cmd = 'fd  --color=never --full-path --type file --hidden --exclude=".git" "' .. file_pattern .. '"'
		local result = vim.fn.systemlist(cmd)
		return result
	end

	vim.opt.findfunc = "v:lua.Fd"
	vim.keymap.set("n", "<C-p>", ":find ", { desc = "xavier: Project Files" })
	return {}
end

return {
	{
		"ibhagwan/fzf-lua",
		enabled = searcher == "fzf-lua",
		config = function()
			require("fzf-lua").setup({
				winopts = {
					height = 0.85,
					width = 0.80,
					preview = {
						default = "bat",
						border = "border",
					},
				},
				fzf_opts = {
					["--layout"] = "reverse",
					["--info"] = "inline",
				},
				files = {
					prompt = "Files❯ ",
					cmd = "fd --type f --hidden --exclude .git",
					git_icons = true,
					file_icons = true,
				},
				grep = {
					prompt = "Rg❯ ",
					input_prompt = "Grep For❯ ",
					cmd = "rg --vimgrep",
					git_icons = true,
					file_icons = true,
				},
			})

			vim.keymap.set("n", "<C-p>", function()
				require("fzf-lua").files()
			end, { desc = "fzf-lua: Project Files" })

			vim.keymap.set("n", ";g", function()
				require("fzf-lua").live_grep()
			end, { desc = "fzf-lua: Live grep" })

			vim.keymap.set("n", "<leader>tj", function()
				require("fzf-lua").builtin()
			end, { desc = "fzf-lua: Builtins" })

			vim.keymap.set("n", "<leader>tf", function()
				require("fzf-lua").files()
			end, { desc = "fzf-lua: Find files" })

			vim.keymap.set("n", "<leader>th", function()
				require("fzf-lua").help_tags()
			end, { desc = "fzf-lua: Help tags" })

			vim.keymap.set("n", "<leader>c", function()
				require("fzf-lua").files({ cwd = "~/.config/nvim/" })
			end, { desc = "fzf-lua: Open nvim init.lua" })
		end,
	},
}
