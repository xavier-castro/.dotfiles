vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "-", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a')

vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj')

vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i')

vim.keymap.set("n", "<leader>ca", function()
	require("cellular-automaton").start_animation("make_it_rain")
end)

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- Ai's
vim.keymap.set("n", "<M-c>", "<cmd>silent !tmux neww claude --dangerously-skip-permissions<CR>")
vim.keymap.set("n", "<M-o>", "<cmd>silent !tmux neww opencode<CR>")
vim.keymap.set("n", "<M-g>", "<cmd>silent !tmux neww gemimni<CR>")

-- Open External Programs
vim.keymap.set("n", "<M-o>", function()
	vim.cmd([[ silent !tmux new-window /usr/local/bin/opencode]])
end, { desc = "Open Opencode" })

vim.keymap.set("n", "<M-g>", function()
	vim.cmd([[ silent !tmux new-window /Users/xavier/.volta/bin/gemini]])
end, { desc = "Open Gemini" })

vim.keymap.set("n", "<M-c>", function()
	vim.cmd([[ silent !tmux new-window /Users/xavier/.volta/bin/claude  --dangerously-skip-permissions]])
end, { desc = "Open Claude CLI" })

-- Format
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

-- Toggle qflist window
vim.keymap.set("n", "<Leader>q", function()
	vim.cmd(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and "cclose" or "copen")
end)

-- Add all diagnostics to the qflist
vim.keymap.set("n", "grq", function()
	vim.diagnostic.setqflist({ open = false })
	pcall(vim.cmd.cc)
end)

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diaqnostic [Q]uickfix list" })

-- ============================================================================
-- BRAIN NAVIGATION KEYMAPS
-- ============================================================================
-- Quick access to Brain
vim.keymap.set("n", "<leader>bb", function()
	vim.cmd("cd ~/personal/notes")
	vim.cmd("edit README.md")
end, { desc = "Open Brain main page" })

-- Brain sections
vim.keymap.set("n", "<leader>bd", function()
	local today = os.date("%Y-%m-%d")
	local year = os.date("%Y")
	vim.cmd("cd ~/personal/notes/daily/" .. year)
	vim.cmd("edit " .. today .. ".md")
end, { desc = "Open today's daily note" })

vim.keymap.set("n", "<leader>bi", function()
	vim.cmd("cd ~/personal/notes/inbox")
	vim.cmd("Telescope find_files")
end, { desc = "Open Brain inbox" })

vim.keymap.set("n", "<leader>ba", function()
	vim.cmd("cd ~/personal/notes/areas")
	vim.cmd("Telescope find_files")
end, { desc = "Browse Brain areas" })

vim.keymap.set("n", "<leader>bp", function()
	vim.cmd("cd ~/personal/notes/projects")
	vim.cmd("Telescope find_files")
end, { desc = "Browse Brain projects" })

vim.keymap.set("n", "<leader>br", function()
	vim.cmd("cd ~/personal/notes/resources")
	vim.cmd("Telescope find_files")
end, { desc = "Browse Brain resources" })

vim.keymap.set("n", "<leader>bt", function()
	vim.cmd("cd ~/personal/notes/templates")
	vim.cmd("Telescope find_files")
end, { desc = "Browse Brain templates" })

-- Global Brain search
vim.keymap.set("n", "<leader>bs", function()
	vim.cmd("cd ~/personal/notes")
	vim.cmd("Telescope live_grep")
end, { desc = "Search across entire Brain" })

-- Quick note creation
vim.keymap.set("n", "<leader>bn", function()
	local note_name = vim.fn.input("Note name: ")
	if note_name ~= "" then
		vim.cmd("cd ~/personal/notes/inbox")
		vim.cmd("edit " .. note_name .. ".md")
	end
end, { desc = "Create new note in inbox" })
