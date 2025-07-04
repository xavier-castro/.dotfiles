-- Enhanced None-ls configuration for Next.js and Rust development

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"
    local utils = require "null-ls.utils"

    -- Helper function to check if file exists in project
    local function has_file(patterns) 
      return utils.root_has_file(patterns) 
    end

    -- Helper function to conditionally add source based on project type
    local function conditional_source(source, condition_files)
      if condition_files then
        return source.with {
          condition = function() return has_file(condition_files) end,
        }
      end
      return source
    end

    -- Base sources (always available)
    local base_sources = {
      -- Lua formatting (always enabled for nvim config)
      null_ls.builtins.formatting.stylua,

      -- Universal formatters
      null_ls.builtins.formatting.prettier.with {
        filetypes = { "json", "yaml", "markdown", "html", "css", "scss" },
      },

      -- Shell script formatting
      null_ls.builtins.formatting.shfmt.with {
        extra_args = { "-i", "2", "-ci" },
      },

      -- YAML linting
      null_ls.builtins.diagnostics.yamllint,

      -- Spell checking for markdown and text
      null_ls.builtins.diagnostics.codespell.with {
        filetypes = { "markdown", "text", "gitcommit" },
      },
    }

    -- Next.js/TypeScript/JavaScript sources
    local nextjs_sources = {
      -- TypeScript/JavaScript formatting with project-specific prettier
      conditional_source(
        null_ls.builtins.formatting.prettier.with {
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
            "astro",
          },
          prefer_local = "node_modules/.bin",
        },
        { "package.json", ".prettierrc", ".prettierrc.json", ".prettierrc.js", "prettier.config.js" }
      ),

      -- ESLint for linting and code actions
      conditional_source(
        null_ls.builtins.diagnostics.eslint.with {
          prefer_local = "node_modules/.bin",
          condition = function(utils)
            return utils.root_has_file { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js" }
          end,
        },
        { "package.json" }
      ),

      conditional_source(
        null_ls.builtins.code_actions.eslint.with {
          prefer_local = "node_modules/.bin",
          condition = function(utils)
            return utils.root_has_file { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js" }
          end,
        },
        { "package.json" }
      ),

      -- TypeScript diagnostics (when tsconfig exists)
      conditional_source(
        null_ls.builtins.diagnostics.tsc.with {
          prefer_local = "node_modules/.bin",
        },
        { "tsconfig.json", "jsconfig.json" }
      ),

      -- Tailwind CSS class sorting
      conditional_source(
        null_ls.builtins.formatting.rustywind,
        { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs" }
      ),
    }

    -- Rust sources
    local rust_sources = {
      -- Rust formatting with rustfmt
      conditional_source(
        null_ls.builtins.formatting.rustfmt.with {
          extra_args = { "--edition", "2021" },
        },
        { "Cargo.toml", "Cargo.lock" }
      ),

      -- Clippy for advanced Rust linting
      conditional_source(
        null_ls.builtins.diagnostics.clippy.with {
          extra_args = { "--", "-W", "clippy::pedantic", "-W", "clippy::nursery" },
        },
        { "Cargo.toml" }
      ),
    }

    -- Additional language sources
    local additional_sources = {
      -- Python
      conditional_source(
        null_ls.builtins.formatting.black.with {
          extra_args = { "--line-length", "88" },
        },
        { "pyproject.toml", "setup.py", "requirements.txt" }
      ),

      conditional_source(null_ls.builtins.formatting.isort, { "pyproject.toml", "setup.py", "requirements.txt" }),

      conditional_source(null_ls.builtins.diagnostics.ruff, { "pyproject.toml", "setup.py", "requirements.txt" }),

      -- Go (commented out - uncomment if you have Go installed)
      -- conditional_source(null_ls.builtins.formatting.gofmt, { "go.mod", "go.sum" }),
      -- conditional_source(null_ls.builtins.formatting.goimports, { "go.mod", "go.sum" }),

      -- TOML formatting (for Cargo.toml, pyproject.toml)
      null_ls.builtins.formatting.taplo,

      -- SQL formatting
      null_ls.builtins.formatting.sqlfluff.with {
        extra_args = { "--dialect", "postgres" },
      },
    }

    -- Combine all sources
    local all_sources = {}
    vim.list_extend(all_sources, base_sources)
    vim.list_extend(all_sources, nextjs_sources)
    vim.list_extend(all_sources, rust_sources)
    vim.list_extend(all_sources, additional_sources)

    -- Only insert new sources, preserving existing ones
    opts.sources = require("astrocore").list_insert_unique(opts.sources, all_sources)

    -- Enhanced configuration
    opts.debug = false
    opts.temp_dir = vim.fn.stdpath "cache" .. "/null-ls"

    -- Performance: only run diagnostics on save and when entering buffer
    opts.update_in_insert = false
    opts.debounce = 200

    return opts
  end,
}
