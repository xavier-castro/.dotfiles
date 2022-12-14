local status, lspkind = pcall(require, "lspkind")
if (not status) then return end
local icons = require("xavier.icons")

lspkind.init({
  mode = 'symbol',
  preset = 'codicons',
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
    CmpItemKindCopilot = icons.ui.Bug,
    Copilot = icons.ui.Bug,
  },

  before = function(entry, vim_item)
    if entry.source.name == "copilot" then
      vim_item.kind = icons.ui.Bug
      vim_item.kind_hl_group = "CmpItemKindCopilot"
    end
    if entry.source.name == "cmp_tabnine" then
      vim_item.kind = lspkind.symbol_map.Event
      vim_item.kind_hl_group = "CmpItemKindTabNine"
    end


    vim_item.menu = ({
      nvim_lsp = "",
      buffer = "",
      nvim_lua = "",
      copilot = "",
      cmp_tabnine = "",
      luasnip = "",
      path = "",
      emoji = "",
    })[entry.source.name]
    return vim_item
  end
})

vim.api.nvim_set_hl(0, "CmpItemKindTabNine", { fg = "#6638f0" })
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
