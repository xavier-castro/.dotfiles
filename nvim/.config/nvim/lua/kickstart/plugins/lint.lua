return {
  'mfussenegger/nvim-lint',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "flake8", "mypy" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
      javascriptreact = { "eslint" },
      -- lua = { "luacheck" }, -- Removed until luacheck is installed
      sh = { "shellcheck" },
      markdown = { "markdownlint" },
      yaml = { "yamllint" },
    }

    -- Configure linters
    lint.linters.flake8 = {
      args = {
        "--max-line-length=88",
        "--extend-ignore=E203",
      },
    }

    -- Customize linters that need special configuration
    -- Commented out until luacheck is installed
    -- lint.linters.luacheck.args = {
    --   "--globals",
    --   "vim",
    --   "--no-max-line-length",
    -- }

    -- Set up auto-linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        require("lint").try_lint()
      end,
    })

    -- Create keybinding to manually trigger linting
    vim.keymap.set("n", "<leader>l", function()
      require("lint").try_lint()
    end, { desc = "Lint current file" })
  end,
} 