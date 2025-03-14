return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      style = {
        { fg = "#9AA6DF" },
      },
      exclude_filetypes = {
        yaml = true,
      },
    },
    indent = {
      enable = false,
      chars = { "┊" },
    },
  },
}
