return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = function(_, opts)
    opts.highlight = { enable = true }

    -- add tsx and treesitter
    vim.list_extend(opts.ensure_installed, {
      "tsx",
      "typescript",
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
    })
  end,
}
