require("xavier.set")
require("xavier.remap")
require("xavier.lazy_init")

local augroup = vim.api.nvim_create_augroup
local xavierGroup = augroup("xavier", {})
local foldGroup = augroup("FoldPersistence", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

-- Save folds when leaving a buffer, load when entering
autocmd({ "BufWinLeave" }, {
	group = foldGroup,
	pattern = { "*" },
	command = "silent! mkview",
})

autocmd({ "BufWinEnter" }, {
	group = foldGroup,
	pattern = { "*" },
	command = "silent! loadview",
})

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

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

autocmd({ "BufWritePre" }, {
	group = xavierGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- autocmd('BufEnter', {
--   group = xavierGroup,
--   callback = function()
--     if vim.bo.filetype == "markdown" then
--       vim.cmd.colorscheme("rose-pine")
--     else
--       vim.cmd.colorscheme("256_noir")
--     end
--   end
-- })

-- autocmd("LspAttach", {
-- 	group = xavierGroup,
-- 	callback = function(e)
-- 		local opts = { buffer = e.buf, silent = true }
-- 		local keymap = vim.keymap -- for conciseness
-- 				-- Buffer local mappings
-- 				-- Check `:help vim.lsp.*` for documentation on any of the below functions
--
-- 				-- keymaps
-- 				opts.desc = "Show LSP references"
-- 				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
--
-- 				opts.desc = "Go to declaration"
-- 				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
--
-- 				opts.desc = "Show LSP definitions"
-- 				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
--
-- 				opts.desc = "Show LSP implementations"
-- 				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
--
-- 				opts.desc = "Show LSP type definitions"
-- 				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
--
-- 				opts.desc = "See available code actions"
-- 				keymap.set({ "n", "v" }, "<leader>vca", function()
-- 					vim.lsp.buf.code_action()
-- 				end, opts) -- see available code actions, in visual mode will apply to selection
--
-- 				opts.desc = "Smart rename"
-- 				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
--
-- 				opts.desc = "Show buffer diagnostics"
-- 				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
--
-- 				opts.desc = "Show line diagnostics"
-- 				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
--
-- 				opts.desc = "Go to previous diagnostic"
-- 				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
--
-- 				opts.desc = "Go to next diagnostic"
-- 				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
--
-- 				opts.desc = "Show documentation for what is under cursor"
-- 				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
--
-- 				opts.desc = "Restart LSP"
-- 				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
--
-- 				keymap.set("i", "<C-h>", function()
-- 					vim.lsp.buf.signature_help()
-- 				end, opts)
-- 			end,
-- 		})

require("xavier.utils.floating_terminal")
require("xavier.utils.note_lookup")

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.cmd.colorscheme("256_noir")
