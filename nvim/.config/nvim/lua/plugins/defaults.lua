return {
  -- NOTE: LSPCONFIG
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  -- NOTE: Snacks
  {
    "folke/snacks.nvim",
    opts = {
      image = {},
      picker = {},
      explorer = {},
    },
  },
}
