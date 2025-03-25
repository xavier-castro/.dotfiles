return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-avante",
    -- ... Other dependencies
  },
  opts = {
    keymap = {
      ["<CR>"] = {}, -- Disables <CR>
    },
    sources = {
      -- Add 'avante' to the list
      default = { "avante" },
      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {
            -- options for blink-cmp-avante
          },
        },
      },
    },
  },
}
