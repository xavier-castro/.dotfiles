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
    -- Optional, if you keep notes in a specific subdirectory of your vault.
    notes_subdir = "notes",

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "notes/dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%m-%d-%Y",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
  },
}
