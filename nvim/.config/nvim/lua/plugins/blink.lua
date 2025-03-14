return {
  "saghen/blink.cmp",
  opts = {
    -- keymap = {
    --   preset = "enter",
    --   ["<C-c>"] = { "hide" },
    --   ["<C-k>"] = { "snippet_forward", "fallback" },
    --   ["<C-j>"] = { "snippet_backward", "fallback" },
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
