require("nvim-treesitter.configs").setup({
    ensure_installed = { 
      "typescript", 
      "tsx", 
      "javascript", 
      "html", 
      "css", 
      "json", 
      "lua", 
      "markdown", 
      "prisma"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
  })