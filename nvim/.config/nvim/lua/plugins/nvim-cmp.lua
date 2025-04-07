return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-calc",
    "stevearc/conform.nvim",
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      version = "v2.*",
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
      config = function()
        require('config.snippets')
      end,
    },
    -- for autocompletion
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
      }
    })
    local cmp = require("cmp")

    local luasnip = require("luasnip")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "calc" },
      }),
    })
  end,
}
