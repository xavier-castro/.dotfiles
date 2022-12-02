local status, lspkind = pcall(require, "lspkind")
if (not status) then return end
-- local icons = require("xavier.icons")

lspkind.init({
  -- enables text annotations
  --
  -- default: true
  mode = 'symbol',

  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)
  --
  -- default: 'default'
  preset = 'codicons',

  -- override preset symbols
  --
  -- default: {}
  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
    CmpItemKindCopilot = "",
    Copilot = "",
  },

  before = function(entry, vim_item)
    if entry.source.name == "cmp_tabnine" then
      local detail = (entry.completion_item.data or {}).detail
      vim_item.kind = ""
      if detail and detail:find('.*%%.*') then
        vim_item.kind = vim_item.kind .. ' ' .. detail
      end

      if (entry.completion_item.data or {}).multiline then
        vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
      end
    end
    if entry.source.name == "copilot" then
      vim_item.kind = ""
      vim_item.kind_hl_group = "CmpItemKindCopilot"
    end
    -- local maxwidth = 80
    -- vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

    vim_item.menu = ({
      nvim_lsp = "",
      nvim_lua = "",
      luasnip = "",
      buffer = "",
      cmp_tabnine = "",
      path = "",
    })[entry.source.name]
    return vim_item
  end
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
