-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

local map = vim.keymap.set

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ NvChad-style keymaps ]]

-- Insert mode navigation
map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- General
map("n", "<C-s>", "<cmd>w<CR>", { desc = "General save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General copy whole file" })

-- Line numbers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- NvCheatsheet
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Tabufline (buffer management)
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer close" })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree focus window" })

-- Telescope
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
map("n", "<leader>ss", "<cmd>Telescope builtin<CR>", { desc = "[S]earch [S]elect Telescope" })
map("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", "<cmd>Telescope resume<CR>", { desc = "[S]earch [R]esume" })
map("n", "<leader>s.", "<cmd>Telescope oldfiles<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", "<cmd>Telescope buffers<CR>", { desc = "[ ] Find existing buffers" })

-- NvChad telescope extensions
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_bffer_fuzzy_find<CR>", { desc = "Telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })

-- Slightly advanced example of overriding default behavior and theme
map("n", "<leader>s/", function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
map("n", "<leader>s/", function()
  require("telescope.builtin").live_grep {
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  }
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
map("n", "<leader>sn", function()
  require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
end, { desc = "[S]earch [N]eovim files" })

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })

-- New terminals (with fallback to basic terminal if nvchad.term not available)
map("n", "<leader>h", function()
  local ok, nvchad_term = pcall(require, "nvchad.term")
  if ok then
    nvchad_term.new { pos = "sp" }
  else
    vim.cmd "split | terminal"
  end
end, { desc = "Terminal new horizontal term" })

map("n", "<leader>v", function()
  local ok, nvchad_term = pcall(require, "nvchad.term")
  if ok then
    nvchad_term.new { pos = "vsp" }
  else
    vim.cmd "vsplit | terminal"
  end
end, { desc = "Terminal new vertical term" })

-- Toggleable terminals
map({ "n", "t" }, "<A-v>", function()
  local ok, nvchad_term = pcall(require, "nvchad.term")
  if ok then
    nvchad_term.toggle { pos = "vsp", id = "vtoggleTerm" }
  else
    vim.cmd "vsplit | terminal"
  end
end, { desc = "Terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  local ok, nvchad_term = pcall(require, "nvchad.term")
  if ok then
    nvchad_term.toggle { pos = "sp", id = "htoggleTerm" }
  else
    vim.cmd "split | terminal"
  end
end, { desc = "Terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  local ok, nvchad_term = pcall(require, "nvchad.term")
  if ok then
    nvchad_term.toggle { pos = "float", id = "floatTerm" }
  else
    vim.cmd "terminal"
  end
end, { desc = "Terminal toggle floating term" })

-- Theme switcher
map("n", "<leader>th", function()
  local ok, nvchad_themes = pcall(require, "nvchad.themes")
  if ok then
    nvchad_themes.open()
  else
    print "NvChad themes not available. Use :colorscheme to change themes manually."
  end
end, { desc = "Telescope nvchad themes" })

-- WhichKey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "Whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "Whichkey query lookup" })

-- xavier-castro + theprimeagen settings
map("i", "jk", "<ESC>")

-- Externally run programs
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux Sessionizer" })

vim.keymap.set("n", "<M-o>", function()
  vim.cmd [[ silent !tmux new-window /usr/local/bin/opencode]]
end, { desc = "Open Opencode" })

vim.keymap.set("n", "<M-c>", function()
  vim.cmd [[ silent !tmux new-window /Users/xavier/.volta/bin/claude ]]
end, { desc = "Open Claude CLI" })

-- MARK: Put Imported binds here
require "scripts.floating_term"
