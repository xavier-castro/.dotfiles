return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    -- Define formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      yaml = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
      rust = { "rustfmt" },
      go = { "gofmt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      sh = { "shfmt" },
    },
    -- Set up format-on-save
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
      black = {
        prepend_args = { "--line-length", "88" },
      },
    },
  },
  init = function()
    -- Add commands to toggle format-on-save
    vim.api.nvim_create_user_command("FormatToggle", function(args)
      if args.bang then
        -- FormatToggle! will toggle globally
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print("Global autoformatting " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
      else
        -- FormatToggle will toggle for the current buffer
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        print("Buffer autoformatting " .. (vim.b.disable_autoformat and "disabled" or "enabled"))
      end
    end, { bang = true, desc = "Toggle autoformatting" })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
