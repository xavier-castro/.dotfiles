return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  dependencies = {
    "lua-utils.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "pysan3/pathlib.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.summary"] = {},
        ["core.export.markdown"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/personal/notes",
              journal = "~/personal/journal",
            },
            default_workspace = "notes",
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.integrations.nvim-cmp"] = {},
      },
    })
  end,
}
