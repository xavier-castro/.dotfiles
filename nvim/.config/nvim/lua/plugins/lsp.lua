return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        tailwindcss = {},
        ts_ls = {},
        html = {},
        yamlls = {},
        lua_ls = {},
      },
      inlay_hints = { enabled = false },
    },
  },
}
