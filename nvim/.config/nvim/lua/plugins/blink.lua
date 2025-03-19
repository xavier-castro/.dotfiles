return {
  "saghen/blink.cmp",
  opts = {
    keymap = { preset = "default" },
    signature = { window = { border = "single" } },
    completion = {
      documentation = { window = { border = "single" } },
      menu = {
        border = "single",
        draw = {
          components = {
            kind_icon = {
              ellipsis = true,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
  },
}
