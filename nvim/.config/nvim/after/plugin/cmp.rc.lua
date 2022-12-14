local status, cmp = pcall(require, "cmp")
if (not status) then
  return
end
local lspkind = require 'lspkind'

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip").filetype_extend("javascript", { "javascriptreact" })
require('luasnip').filetype_extend("javascript", { "html" })
require("luasnip").filetype_extend("typescript", { "typescriptreact" })

-- Load custom typescript snippets
require("luasnip.loaders.from_vscode").lazy_load {
  paths = { "./snippets/typescript" }
}

cmp.setup({
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-CR>'] = cmp.mapping.close(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp', group_index = 2 },
      { name = "copilot", group_index = 2 },
      { name = "luasnip", group_index = 2 },
      { name = 'nvim_lua', group_index = 2 },
      { name = "buffer", group_index = 2 },
      { name = "cmp_tabnine", group_index = 2 },
      { name = 'path', group_index = 2 },
      { name = "emoji", group_index = 2 },
    }
  ),
  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      maxwidth = 50
    })
  },
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]
