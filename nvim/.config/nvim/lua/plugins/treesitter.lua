-- Enhanced Treesitter configuration for Next.js and Rust development

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- Core parsers (always installed)
    ensure_installed = {
      -- Neovim essentials
      "lua",
      "vim",
      "vimdoc",
      "query",

      -- Next.js/Web development
      "javascript",
      "typescript",
      "html",
      "css",
      "scss",
      "json",
      "jsonc",
      "yaml",
      "toml",
      "xml",
      "vue",
      "svelte",
      "astro",
      "prisma",
      "graphql",

      -- Rust ecosystem
      "rust",
      "ron", -- Rusty Object Notation

      -- Systems & DevOps
      "bash",
      "fish",
      "dockerfile",
      "gitignore",
      "gitcommit",
      "gitattributes",
      "git_rebase",

      -- Data & Config
      "sql",
      "csv",
      "ini",
      "regex",

      -- Documentation
      "markdown",
      "markdown_inline",
      "latex",
      "bibtex",

      -- Additional languages
      "python",
      "go",
      "c",
      "cpp",
      "cmake",
      "make",
      "ninja",

      -- Embedded/Mobile
      "swift",
      "kotlin",
      "dart",
    },

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- Synchronously install parsers (faster startup)
    sync_install = false,

    -- Ignore parsers for these languages (if installation fails)
    ignore_install = {},

    -- Enhanced syntax highlighting
    highlight = {
      enable = true,

      -- Disable for large files (performance)
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then return true end

        -- Disable for specific filetypes that might cause issues
        local disable_for = { "gitcommit" }
        return vim.tbl_contains(disable_for, lang)
      end,

      -- Use additional vim regex highlighting
      additional_vim_regex_highlighting = {
        "markdown", -- Better markdown highlighting
        "tsx", -- Better JSX highlighting
        "jsx",
      },
    },

    -- Intelligent incremental selection
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<C-s>",
        node_decremental = "<C-backspace>",
      },
    },

    -- Smart indentation
    indent = {
      enable = true,

      -- Disable for problematic languages
      disable = {
        "python", -- Use custom python indentation
        "yaml", -- YAML indentation can be tricky
      },
    },

    -- Code folding
    fold = {
      enable = true,
      disable = {}, -- Can disable for specific languages if needed
    },

    -- Enhanced features for specific languages
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },

    -- Context-aware features
    context_commentstring = {
      enable = true,
      enable_autocmd = false, -- Let Comment.nvim handle this
      config = {
        -- JavaScript/TypeScript
        javascript = "// %s",
        typescript = "// %s",
        tsx = {
          __default = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          jsx_attribute = "// %s",
          comment = "// %s",
        },
        jsx = {
          __default = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          jsx_attribute = "// %s",
          comment = "// %s",
        },
        -- Rust
        rust = "// %s",
        -- Other web languages
        vue = "<!-- %s -->",
        svelte = "<!-- %s -->",
        astro = "<!-- %s -->",
        html = "<!-- %s -->",
        css = "/* %s */",
        scss = "/* %s */",
        -- Config files
        yaml = "# %s",
        toml = "# %s",
        json = "",
        jsonc = "// %s",
      },
    },

    -- Rainbow parentheses/brackets
    rainbow = {
      enable = true,
      disable = { "html", "jsx", "tsx" }, -- Can interfere with JSX
      extended_mode = true,
      max_file_lines = 2000,
      colors = {
        "#cc241d", -- Red
        "#d65d0e", -- Orange
        "#d79921", -- Yellow
        "#689d6a", -- Green
        "#458588", -- Blue
        "#b16286", -- Purple
        "#a89984", -- Gray
      },
    },

    -- Autopairs integration
    autopairs = {
      enable = true,
    },

    -- Performance optimizations
    performance = {
      max_file_size = 1024 * 1024, -- 1MB
      disable_for_large_buf = function(buf)
        local line_count = vim.api.nvim_buf_line_count(buf)
        return line_count > 10000
      end,
    },
  },

  -- Additional treesitter plugins
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag", -- Auto close/rename HTML tags
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
        require("nvim-treesitter.configs").setup {
          sync_install = true,
          auto_install = true,
          ensure_installed = {},
          modules = {},
          ignore_install = {},

          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                -- Functions
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                -- Language specific
                ["ar"] = "@assignment.rhs", -- Rust: right-hand side
                ["al"] = "@assignment.lhs", -- Rust: left-hand side
              },
              selection_modes = {
                ["@parameter.outer"] = "v",
                ["@function.outer"] = "V",
                ["@class.outer"] = "<c-v>",
              },
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
                ["]a"] = "@parameter.inner",
              },
              goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
                ["]A"] = "@parameter.inner",
              },
              goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
                ["[a"] = "@parameter.inner",
              },
              goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
                ["[A"] = "@parameter.inner",
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ["<leader>sp"] = "@parameter.inner",
                ["<leader>sf"] = "@function.outer",
              },
              swap_previous = {
                ["<leader>sP"] = "@parameter.inner",
                ["<leader>sF"] = "@function.outer",
              },
            },
          },
        }
      end,
    },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup {
          opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = false,
          },
          per_filetype = {
            ["html"] = { enable_close = false },
            ["jsx"] = { enable_close = true, enable_rename = true },
            ["tsx"] = { enable_close = true, enable_rename = true },
            ["vue"] = { enable_close = true, enable_rename = true },
            ["svelte"] = { enable_close = true, enable_rename = true },
            ["astro"] = { enable_close = true, enable_rename = true },
          },
        }
      end,
    },
  },
}
