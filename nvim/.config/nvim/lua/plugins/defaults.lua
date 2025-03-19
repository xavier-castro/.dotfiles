return {
  -- NOTE: Render Markdown
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  -- NOTE: LSPCONFIG
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  -- NOTE: Typescript tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
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
