return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      style = {
        { fg = "#3D3D3D" },
      },
    },
    indent = {
      enable = false,
      chars = { "┊" },
    },
  },
}
