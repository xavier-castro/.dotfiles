return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "enter",
      ["<C-k>"] = { "snippet_forward", "fallback" },
      ["<C-j>"] = { "snippet_backward", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = {},
    },
    completion = {
      menu = {
        winblend = vim.o.pumblend,
      },
    },
    signature = {
      enabled = false,
      window = {
        winblend = vim.o.pumblend,
      },
    },
  },
}
