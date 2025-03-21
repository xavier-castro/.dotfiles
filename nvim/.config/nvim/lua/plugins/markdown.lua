return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    event = "bufread",
    ft = "markdown",
    opts = {
      workspaces = {
        {
          name = "xcvault",
          path = "~/xcvault",
        },
      },
      ui = { enable = false },
      -- optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "notes",

      daily_notes = {
        -- optional, if you keep daily notes in a separate directory.
        folder = "notes/dailies",
        -- optional, if you want to change the date format for the id of daily notes.
        date_format = "%m-%d-%y",
        -- optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%b %-d, %y",
        -- optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },
    },
  },
  -- NOTE: Render Markdown
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  -- NOTE: MDX Support
  {
    "davidmh/mdx.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  -- NOTE: Markdown Previewer
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        filetype = { "markdown", "conf" },
      })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
}
