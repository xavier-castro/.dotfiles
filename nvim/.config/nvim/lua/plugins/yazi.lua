return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    "folke/snacks.nvim",
  },
  keys = {
    {
      "<Leader>n",
      ":Yazi cwd<CR>",
      silent = true,
    },
    {
      "<Leader>N",
      ":Yazi<CR>",
      silent = true,
    },
  },
  opts = {
    open_for_directories = true,
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
