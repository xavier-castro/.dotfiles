return {
  "epwalsh/obsidian.nvim",
  version = "*",
  -- lazy = true,
  ft = "markdown",
  opts = {
    workspaces = {
      {
        name = "vault",
        path = "~/xcvault/",
      },
      {
        name = "notes",
        path = "~/xcvault/notes/",
      },
    },
    ui = { enable = false },
  },
}
