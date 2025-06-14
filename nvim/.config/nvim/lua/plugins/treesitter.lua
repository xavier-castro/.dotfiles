return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local parser_configs = require 'nvim-treesitter.parsers'.get_parser_configs()
      parser_configs.cds = {
        install_info = {
          url = 'https://github.com/cap-js-community/tree-sitter-cds.git',
          branch = 'main',
          files = { 'src/parser.c', 'src/scanner.c' }
        },
        filetype = 'cds'
      }
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "javascript", "toml", "cds", "vimdoc", "javascript", "typescript", "c", "lua", "rust",
          "jsdoc", "bash", "go" },
        auto_install = true,
        indent = {
          enable = true
        },
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = function()
      require 'treesitter-context'.setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false,      -- Enable multiwindow support.
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end
  }
}
