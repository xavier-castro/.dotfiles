---@diagnostic disable: missing-fields
return {
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    priority = 99,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",
      "olimorris/codecompanion.nvim",
    },

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})

      -- Function to preview tailwind colors
      local function formatForTailwindCSS(entry, vim_item)
        if vim_item.kind == "Color" and entry.completion_item.documentation then
          local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
          if r then
            local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
            local group = "Tw_" .. color
            if vim.fn.hlID(group) < 1 then
              vim.api.nvim_set_hl(0, group, {
                fg = "#" .. color,
              })
            end
            vim_item.kind = "●"
            vim_item.kind_hl_group = group
            return vim_item
          end
        end
        vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
        return vim_item
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<M-b>"] = cmp.mapping.scroll_docs(-4),
          ["<M-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-f>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<Tab>"] = nil,
          ["<S-Tab>"] = nil,
          ["<C-a>"] = cmp.mapping(function(fallback)
            local suggestion = require("copilot.suggestion")
            if suggestion.is_visible() then
              suggestion.accept()
            elseif cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end, { "i", "c" }),
          ["<C-j>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              -- local suggestion = require("copilot.suggestion")
              -- if suggestion.is_visible() then
              -- 	suggestion.accept()
              -- local copilot_keys = vim.fn["copilot#Accept"]()
              -- if copilot_keys ~= "" then
              -- 	vim.api.nvim_feedkeys(copilot_keys, "i", true)
              -- else
              fallback()
              -- end
            end
          end,

          ["<C-k>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end,
        }),
        sources = {
          { name = "luasnip", max_item_count = 3 },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
          {
            name = "nvim_lsp",
            max_item_count = 20,
            entry_filter = entry_filter,
          },
          { name = "nvim_lua" },
          { name = "buffer", max_item_count = 8 },
          { name = "codecompanion" },
          { name = "neorg" },
        },
        window = {
          documentation = {
            max_width = 80,
            max_height = 20,
          },
        },
        performance = {
          max_view_entries = 64,
        },
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            before = function(entry, vim_item)
              vim_item = formatForTailwindCSS(entry, vim_item)
              return vim_item
            end,
          }),
        },
      })
    end,
  },
}
