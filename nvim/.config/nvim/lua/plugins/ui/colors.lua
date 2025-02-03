return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({
        transparent = true,
      })
      ColorMyPencils()
    end,
  },
}
