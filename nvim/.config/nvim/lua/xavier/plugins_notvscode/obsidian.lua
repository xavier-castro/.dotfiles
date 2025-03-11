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
    template = nil
  },
    ui = { enable = false },
  },
}
