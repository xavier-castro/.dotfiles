---@diagnostic disable: missing-fields
-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end
vim.opt.rtp:prepend(lazypath)

local venice_api_key = os.getenv 'VENICE_API_KEY'

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Add plugins
require('lazy').setup({
  'tpope/vim-fugitive', -- Git commands in nvim
  'tpope/vim-rhubarb', -- Fugitive-companion to interact with github
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      -- Define formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        yaml = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        scss = { { 'prettierd', 'prettier' } },
        markdown = { { 'prettierd', 'prettier' } },
        rust = { 'rustfmt' },
        go = { 'gofmt' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        sh = { 'shfmt' },
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
          prepend_args = { '-i', '2', '-ci' },
        },
        black = {
          prepend_args = { '--line-length', '88' },
        },
      },
    },
    init = function()
      -- Add commands to toggle format-on-save
      vim.api.nvim_create_user_command('FormatToggle', function(args)
        if args.bang then
          -- FormatToggle! will toggle globally
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          print('Global autoformatting ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
        else
          -- FormatToggle will toggle for the current buffer
          vim.b.disable_autoformat = not vim.b.disable_autoformat
          print('Buffer autoformatting ' .. (vim.b.disable_autoformat and 'disabled' or 'enabled'))
        end
      end, { bang = true, desc = 'Toggle autoformatting' })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        python = { 'flake8', 'mypy' },
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        typescriptreact = { 'eslint' },
        javascriptreact = { 'eslint' },
        lua = { 'luacheck' },
        sh = { 'shellcheck' },
        markdown = { 'markdownlint' },
        yaml = { 'yamllint' },
      }

      -- Configure linters
      lint.linters.flake8 = {
        args = {
          '--max-line-length=88',
          '--extend-ignore=E203',
        },
      }

      -- Customize linters that need special configuration
      lint.linters.luacheck.args = {
        '--globals',
        'vim',
        '--no-max-line-length',
      }

      -- Set up auto-linting
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })

      -- Create keybinding to manually trigger linting
      vim.keymap.set('n', '<leader>l', function()
        require('lint').try_lint()
      end, { desc = 'Lint current file' })
    end,
  },
  { -- Enhanced LSP UIs
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  'stevearc/oil.nvim', -- More modern netrw
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        transparent = true,
      }
    end,
  }, -- Colorscheme
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Add git related info in the signs columns and popups
  'lewis6991/gitsigns.nvim',
  'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter-textobjects', -- Additional textobjects for treesitter
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  'williamboman/mason.nvim', -- Automatically install LSPs to stdpath for neovim
  'williamboman/mason-lspconfig.nvim', -- ibid
  'folke/neodev.nvim', -- Lua language server configuration for nvim
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
      filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason', 'lazydev' },
    },
    config = function(_, opts)
      vim.opt.foldlevelstart = 99
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'folke/trouble.nvim', opts = {} },
  {
    'mbbill/undotree',

    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you have trouble with this installation, refer to the README for telescope-fzf-native.
    build = 'make',
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          venice = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              name = 'venice',
              formatted_name = 'Venice',
              roles = {
                llm = 'assistant',
                user = 'user',
              },
              opts = {
                stream = true,
              },
              features = {
                text = true,
                tokens = true,
                vision = false,
              },
              env = {
                url = 'https://api.venice.ai/api',
                chat_url = '/v1/chat/completions',
                -- api_key = "",  <-- get from sys env: OPENAI_API_KEY
                api_key = venice_api_key,
              },
              schema = {
                model = {
                  default = 'deepseek-r1-671b',
                  -- Other models available:
                  --   llama-3.1-405b
                  --   llama-3.2-3b
                  --   llama-3.3-70b
                  --   dolphin-2.9.2-qwen2-72b
                  --   deepseek-r1-llama-70b
                  --   deepseek-r1-671b
                  --   qwen2.5-coder-32b
                  --   qwen-2.5-vl
                },
                temperature = {
                  order = 2,
                  mapping = 'parameters',
                  type = 'number',
                  optional = true,
                  default = 0.8,
                  desc = 'What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.',
                  validate = function(n)
                    return n >= 0 and n <= 2, 'Must be between 0 and 2'
                  end,
                },
                max_completion_tokens = {
                  order = 3,
                  mapping = 'parameters',
                  type = 'integer',
                  optional = true,
                  default = nil,
                  desc = 'An upper bound for the number of tokens that can be generated for a completion.',
                  validate = function(n)
                    return n > 0, 'Must be greater than 0'
                  end,
                },
                presence_penalty = {
                  order = 4,
                  mapping = 'parameters',
                  type = 'number',
                  optional = true,
                  default = 0,
                  desc = "Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.",
                  validate = function(n)
                    return n >= -2 and n <= 2, 'Must be between -2 and 2'
                  end,
                },
                top_p = {
                  order = 5,
                  mapping = 'parameters',
                  type = 'number',
                  optional = true,
                  default = 0.9,
                  desc = 'A higher value (e.g., 0.95) will lead to more diverse text, while a lower value (e.g., 0.5) will generate more focused and conservative text. (Default: 0.9)',
                  validate = function(n)
                    return n >= 0 and n <= 1, 'Must be between 0 and 1'
                  end,
                },
                stop = {
                  order = 6,
                  mapping = 'parameters',
                  type = 'string',
                  optional = true,
                  default = nil,
                  desc = 'Sets the stop sequences to use. When this pattern is encountered the LLM will stop generating text and return. Multiple stop patterns may be set by specifying multiple separate stop parameters in a modelfile.',
                  validate = function(s)
                    return s:len() > 0, 'Cannot be an empty string'
                  end,
                },
                frequency_penalty = {
                  order = 8,
                  mapping = 'parameters',
                  type = 'number',
                  optional = true,
                  default = 0,
                  desc = "Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.",
                  validate = function(n)
                    return n >= -2 and n <= 2, 'Must be between -2 and 2'
                  end,
                },
                logit_bias = {
                  order = 9,
                  mapping = 'parameters',
                  type = 'map',
                  optional = true,
                  default = nil,
                  desc = 'Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.',
                  subtype_key = {
                    type = 'integer',
                  },
                  subtype = {
                    type = 'integer',
                    validate = function(n)
                      return n >= -100 and n <= 100, 'Must be between -100 and 100'
                    end,
                  },
                },
              },
            })
          end,
        },
        strategies = {
          agent = { adapter = 'venice' },
          chat = { adapter = 'anthropic' },
          inline = { adapter = 'anthropic' },
        },
      }
      vim.keymap.set({ 'n', 'v' }, '<M-g>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v' }, '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
      vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
}, {})

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd.colorscheme 'xcnoir'

-- Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
  },
}

-- Enable Comment.nvim
require('Comment').setup()

-- Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Add indent guides
require('ibl').setup {
  indent = { char = '┊' },
  whitespace = { remove_blankline_trail = false },
}

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr })
    vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr })
  end,
}

-- Oil
require('oil').setup {
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
  },
  skip_confirm_for_simple_edits = true,
}
vim.keymap.set('n', '<leader>-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
-- open parent dir in float window
vim.keymap.set('n', '-', require('oil').toggle_float)

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'oil', -- Adjust if Oil uses a specific file type identifier
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

-- Add leader shortcuts
vim.keymap.set('n', '<leader><space>', function()
  require('telescope.builtin').buffers { sort_lastused = true }
end)
vim.keymap.set('n', '<leader>sf', function()
  require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '<leader>sb', function()
  require('telescope.builtin').current_buffer_fuzzy_find()
end)
vim.keymap.set('n', '<leader>sh', function()
  require('telescope.builtin').help_tags()
end)
vim.keymap.set('n', '<leader>st', function()
  require('telescope.builtin').tags()
end)
vim.keymap.set('n', '<leader>sd', function()
  require('telescope.builtin').grep_string()
end)
vim.keymap.set('n', '<leader>sp', function()
  require('telescope.builtin').live_grep()
end)
vim.keymap.set('n', '<leader>?', function()
  require('telescope.builtin').oldfiles()
end)

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic settings
vim.diagnostic.config {
  virtual_text = false,
  update_in_insert = true,
}

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', '<cmd>Lspsaga show_cursor_diagnostics<CR>')
vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist)

-- LSP settings
require('mason').setup {}
require('mason-lspconfig').setup()

-- Configure lspsaga
require('lspsaga').setup {
  ui = {
    border = 'rounded',
  },
  lightbulb = {
    enable = true,
  },
  symbol_in_winbar = {
    enable = true,
  },
  callhierarchy = {
    layout = 'float', -- can be 'float' or 'normal'
    keys = {
      edit = 'e',
      vsplit = 's',
      split = 'i',
      tabe = 't',
      quit = 'q',
      shuttle = '[w', -- shuttle between left/right windows
      toggle_or_req = 'u',
      close = '<C-c>k',
    },
  },
}

-- Add nvim-lspconfig plugin
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local attach_opts = { silent = true, buffer = bufnr }
  -- LSP Saga keybindings
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, attach_opts)
  vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', attach_opts)
  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', attach_opts)
  vim.keymap.set('n', 'gi', '<cmd>Lspsaga finder imp<CR>', attach_opts)
  vim.keymap.set('n', '<C-s>', '<cmd>Lspsaga signature_help<CR>', attach_opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, attach_opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, attach_opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, attach_opts)
  vim.keymap.set('n', '<leader>D', '<cmd>Lspsaga peek_type_definition<CR>', attach_opts)
  vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', attach_opts)
  vim.keymap.set('n', 'so', '<cmd>Lspsaga finder ref<CR>', attach_opts)
  vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', attach_opts)
  vim.keymap.set('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', attach_opts)
  vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', attach_opts)
  vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', attach_opts)
  vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', attach_opts)
  -- Call hierarchy keybindings
  vim.keymap.set('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<CR>', attach_opts)
  vim.keymap.set('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<CR>', attach_opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'basedpyright', 'vtsls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require('neodev').setup {}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- vim: ts=2 sts=2 sw=2 et
