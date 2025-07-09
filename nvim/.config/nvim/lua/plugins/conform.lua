return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ lsp_fallback = true, async = true, timeout_ms = 500 })
      end,
      desc = "Format document",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports" }, -- "gofumpt"
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "eslint_d" },
      javascriptreact = { "prettierd", "eslint_d" },
      typescriptreact = { "prettierd", "eslint_d" },
      astro = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      -- yaml = { "prettierd", "prettier" },
      markdown = { "prettierd" },
      graphql = { "prettierd", "prettier" },
      ["_"] = { "trim_whitespace", "trim_newlines" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
