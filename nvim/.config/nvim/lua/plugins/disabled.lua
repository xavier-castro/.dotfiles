return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = false },
    picker = { enabled = false },
    indent = {
      enabled = false,
    },
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
