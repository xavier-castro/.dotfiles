return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP Management
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      
      -- Additional functionality
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- This configuration will be handled in another file
      require("config.lspconfig")
    end
  },

  -- LSP UI Enhancements
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.lspsaga")
    end
  }
}