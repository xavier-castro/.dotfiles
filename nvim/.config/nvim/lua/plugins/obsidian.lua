return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  event = "BufRead",
  ft = "markdown",
  opts = {
    workspaces = {
      {
        name = "xcvault",
        path = "~/xcvault",
      },
    },
    ui = { enable = false },
  },
}
