return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "enter",
      ["<C-k>"] = { "snippet_forward", "fallback" },
      ["<C-j>"] = { "snippet_backward", "fallback" },
      ["<CR>"] = {},
    },
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
