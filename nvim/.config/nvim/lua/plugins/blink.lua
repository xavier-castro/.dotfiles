return {
  "saghen/blink.cmp",
  opts = {
    keymap = { preset = "default", ["<Cr>"] = {} },
    completion = {
      menu = {
        winblend = vim.o.pumblend,
      },
    },
    signature = {
      window = {
        winblend = vim.o.pumblend,
      },
    },
  },
}
