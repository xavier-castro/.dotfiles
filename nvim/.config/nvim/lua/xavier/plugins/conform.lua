return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function() require("conform").format { async = true, lsp_fallback = true } end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { c = true, cpp = true }
    --   local lsp_format_opt
    --   if disable_filetypes[vim.bo[bufnr].filetype] then
    --     lsp_format_opt = "never"
    --   else
    --     lsp_format_opt = "fallback"
    --   end
    --   return {
    --     timeout_ms = 500,
    --     lsp_fallback = lsp_format_opt,
    --   }
    -- end,
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports" }, -- "gofumpt"
      bash = { "beautysh" },
      sh = { "beautysh" },
      fish = { "beautysh" },
      zsh = { "beautysh" },
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "eslint_d" },
      javascriptreact = { "prettierd", "eslint_d" },
      typescriptreact = { "prettierd", "eslint_d" },
      astro = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      json = { "jq" },
      jsonc = { "prettierd" },
      yaml = { "prettierd", "prettier" },
      markdown = { "prettierd" },
      graphql = { "prettierd", "prettier" },
      -- Conform can also run multiple formatters sequentially
      python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
