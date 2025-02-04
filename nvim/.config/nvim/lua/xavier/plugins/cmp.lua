return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'onsails/lspkind.nvim',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          -- Load your custom snippets
          require('luasnip.loaders.from_vscode').lazy_load {
            paths = { vim.fn.stdpath 'config' .. '/snippets' },
          }
        end,
      },
    },
    version = 'v0.*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
      snippets = {
        preset = 'luasnip',
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-f>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          'snippet_forward',
          'fallback',
        },
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<M-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<M-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<M-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        menu = {
          auto_show = function()
            if vim.bo.filetype == 'codecompanion' then
              return true
            else
              return false
            end
          end,
          draw = {
            padding = 1,
            gap = 4,
            columns = { { 'kind_icon', 'label', 'label_description', gap = 1 }, { 'kind', gap = 1 } },
            components = {
              kind = {
                text = function(ctx)
                  local len = 10 - string.len(ctx.kind)
                  local space = string.rep(' ', len)
                  return ctx.kind .. space .. '[' .. ctx.source_name .. ']'
                end,
              },
            },
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = function(context)
              return context.mode == 'cmdline'
            end,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 700,
          update_delay_ms = 50,
          window = {
            border = 'single',
          },
        },
      },
      signature = { enabled = true },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        cmdline = function()
          local type = vim.fn.getcmdtype()
          if type == '/' or type == '?' then
            return { 'buffer' }
          elseif type == ':' then
            return { 'cmdline', 'path' }
          else
            return {}
          end
        end,
      },
    },
  },
}
