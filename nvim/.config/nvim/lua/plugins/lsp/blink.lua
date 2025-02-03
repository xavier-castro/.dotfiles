return {
  "saghen/blink.cmp",
  dependencies = {
    "onsails/lspkind.nvim",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        -- Load your custom snippets
        require("luasnip.loaders.from_vscode").lazy_load({
          paths = { vim.fn.stdpath("config") .. "/snippets" },
        })
      end,
    },
    {
      "saghen/blink.compat",
      -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
      version = "*",
      -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
      lazy = true,
      -- make sure to set opts so that lazy.nvim calls blink.compat's setup
      opts = {},
    },
  },
  lazy = false,
  build = "cargo build --release",
  opts = {
    snippets = { preset = "luasnip" },
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-f>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<Tab>"] = nil,
      ["<S-Tab>"] = nil,
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<M-b>"] = { "scroll_documentation_up", "fallback" },
      ["<M-f>"] = { "scroll_documentation_down", "fallback" },
      ["<M-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
    completion = {
      menu = {
        -- border = "rounded",
        draw = {
          padding = 1,
          gap = 4,
          columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind", gap = 1 } },
          components = {
            kind = {
              text = function(ctx)
                local len = 10 - string.len(ctx.kind)
                local space = string.rep(" ", len)
                return ctx.kind .. space .. "[" .. ctx.source_name .. "]"
              end,
            },
          },
        },
      },
      documentation = {
        -- window = { border = "rounded" },
        auto_show = true,
        auto_show_delay_ms = 100,
      },
    },

    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "codecompanion",
        "avante_commands",
        "avante_mentions",
        "avante_files",
      },
      providers = {
        snippets = {
          min_keyword_length = 1,
          score_offset = 4,
        },
        lsp = {
          min_keyword_length = 0,
          score_offset = 3,
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          fallbacks = {},
        },
        path = {
          min_keyword_length = 0,
          score_offset = 2,
        },
        buffer = {
          min_keyword_length = 1,
          score_offset = 1,
        },
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
          enabled = true,
        },
        avante_commands = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 90, -- show at a higher priority than lsp
          enabled = true,
          opts = {},
        },
        avante_files = {
          name = "avante_files",
          module = "blink.compat.source",
          score_offset = 100, -- show at a higher priority than lsp
          enabled = true,
          opts = {},
        },
        avante_mentions = {
          name = "avante_mentions",
          module = "blink.compat.source",
          score_offset = 1000, -- show at a higher priority than lsp
          enabled = true,
          opts = {},
        },
      },
    },
  },
}
