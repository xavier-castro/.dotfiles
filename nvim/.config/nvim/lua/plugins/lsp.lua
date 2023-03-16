return {
  {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },                  -- Required
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
            { 'hrsh7th/cmp-buffer' },                -- Optional
            { 'hrsh7th/cmp-path' },                  -- Optional
            { 'saadparwaiz1/cmp_luasnip' },          -- Optional
            { 'hrsh7th/cmp-nvim-lua' },              -- Optional
            -- Snippets
            { 'L3MON4D3/LuaSnip' },                  -- Required
            { 'rafamadriz/friendly-snippets' },      -- Optional
            -- Me
            {'jose-elias-alvarez/typescript.nvim'},
            { 'jose-elias-alvarez/null-ls.nvim' },
            { "jay-babu/mason-null-ls.nvim", event = { "BufReadPre", "BufNewFile" }, dependencies = {"williamboman/mason.nvim","jose-elias-alvarez/null-ls.nvim"},
            } }, config=function() 
local lsp = require("lsp-zero").preset({name = "recommended"})
lsp.ensure_installed({"tsserver", "eslint", "rust_analyzer"})

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({select = true}),
    ["<C-Space>"] = cmp.mapping.complete(),
    -- go to next placeholder in the snippet
    ["<C-g>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
            luasnip.jump(1)
        else
            fallback()
        end
    end, {"i", "s"}),
    -- go to previous placeholder in the snippet
    ["<C-d>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, {"i", "s"})
})

lsp.setup_nvim_cmp({mapping = cmp_mappings})
lsp.set_preferences({sign_icons = {}})

---@diagnostic disable-next-line: unused-local
lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws",
                   function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd",
                   function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
                   opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
                   opts)
    vim.keymap
        .set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
                   opts)
end)

lsp.setup()

-- Call diagnostics after lspzero setup
vim.diagnostic.config({virtual_text = true})

local null_ls = require("null-ls")
local async_formatting = function(bufnr)
    bufnr = bufnr or vim.lsp.buf.format({timeout_ms = 2000})
end

null_ls.setup({
    -- add your sources / config options here
    sources = {require("typescript.extensions.null-ls.code-actions")},
    debug = false,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = augroup,
                buffer = bufnr,
                callback = function() async_formatting(bufnr) end
            })
        end
    end
})

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require("mason-null-ls").setup({
    ensure_installed = nil,
    automatic_installation = true, -- You can still set this to `true`
    automatic_setup = true
})

-- Required when `automatic_setup` is true
require("mason-null-ls").setup_handlers()

require("typescript").setup({
    disable_commands = false,
    debug = false,
    go_to_source_definition = {fallback = true},
    server = {}
})
            end
    }
}
