return {
  {
    "yetone/avante.nvim",
    lazy = true,
    event = "BufRead",
    build = "make",

    opts = {
      provider = "copilot",
      hints = { enabled = false },
      file_selector = {
        provider = "mini_pick",
      },
    },

    dependencies = {
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "Avante" },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = { enabled = false },
      select = { enabled = false },
    },
  },

}
