require("xavier.set")
require("xavier.remap")
require("xavier.lazy_init")
require("utils.float-terminal")

local augroup = vim.api.nvim_create_augroup
local XavierGroup = augroup('Xavier', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
  require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  group = XavierGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})


local og_virt_text
local og_virt_line
vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
  group = vim.api.nvim_create_augroup('diagnostic_only_virtlines', {}),
  callback = function()
    if og_virt_line == nil then
      og_virt_line = vim.diagnostic.config().virtual_lines
    end

    -- ignore if virtual_lines.current_line is disabled
    if not (og_virt_line and og_virt_line.current_line) then
      if og_virt_text then
        vim.diagnostic.config({ virtual_text = og_virt_text })
        og_virt_text = nil
      end
      return
    end

    if og_virt_text == nil then
      og_virt_text = vim.diagnostic.config().virtual_text
    end

    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

    if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
      vim.diagnostic.config({ virtual_text = og_virt_text })
    else
      vim.diagnostic.config({ virtual_text = false })
    end
  end
})

-- Theme on bufenter
autocmd({ "BufEnter" }, {
  group = XavierGroup,
  pattern = "BufEnter",
  callback = function()
    vim.cmd.colorschmee("rose-pine-moon")
  end
})



autocmd('LspAttach', {
  group = XavierGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show hover doc" })
    vim.keymap.set("n", "<leader>ol", "<cmd>Lspsaga outline<CR>", { desc = "Show outline" })
    vim.keymap.set("n", "gpd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek definition" })
    vim.keymap.set("n", "gpt", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "Peek type definition" })
    vim.keymap.set("n", "gdd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto definition" })
    vim.keymap.set("n", "gdt", "<cmd>Lspsaga goto_type_definition<CR>", { desc = "Goto type definition" })
    vim.keymap.set("n", "<M-.>", "<cmd>Lspsaga finder<cr>")


    vim.keymap.set("n", "[d", function()
      require("lspsaga.diagnostic"):goto_prev()
    end, { desc = "Previous diagnostic" })

    vim.keymap.set("n", "]d", function()
      require("lspsaga.diagnostic"):goto_next()
    end, { desc = "Next diagnostic" })

    vim.keymap.set("n", "[e", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Previous error" })

    vim.keymap.set("n", "]e", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Next error" })
    -- Lspsaga
  end
})


vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
