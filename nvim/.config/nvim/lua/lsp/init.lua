-- Native LSP configuration for Neovim 0.11+

vim.api.nvim_create_user_command('LspStart', function()
  vim.cmd.e()
end, { desc = 'Starts LSP clients in the current buffer' })

vim.api.nvim_create_user_command('LspStop', function(opts)
  for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
    if opts.args == '' or opts.args == client.name then
      client:stop(true)
      vim.notify(client.name .. ': stopped')
    end
  end
end, {
  desc = 'Stop all LSP clients or a specific client attached to the current buffer.',
  nargs = '?',
  complete = function(_, _, _)
    local clients = vim.lsp.get_clients { bufnr = 0 }
    local client_names = {}
    for _, client in ipairs(clients) do
      table.insert(client_names, client.name)
    end
    return client_names
  end,
})

vim.api.nvim_create_user_command('LspRestart', function()
  local detach_clients = {}
  for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
    client:stop(true)
    if vim.tbl_count(client.attached_buffers) > 0 then
      detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
    end
  end
  local timer = vim.uv.new_timer()
  if not timer then
    return vim.notify 'Servers are stopped but havent been restarted'
  end
  timer:start(
    100,
    50,
    vim.schedule_wrap(function()
      for name, client in pairs(detach_clients) do
        local client_id = vim.lsp.start(client[1].config, { attach = false })
        if client_id then
          for _, buf in ipairs(client[2]) do
            vim.lsp.buf_attach_client(buf, client_id)
          end
          vim.notify(name .. ': restarted')
        end
        detach_clients[name] = nil
      end
      if next(detach_clients) == nil and not timer:is_closing() then
        timer:close()
      end
    end)
  )
end, {
  desc = 'Restart all the language client(s) attached to the current buffer',
})

vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
  desc = 'Get all the lsp logs',
})

vim.api.nvim_create_user_command('LspInfo', function()
  vim.cmd 'silent checkhealth vim.lsp'
end, {
  desc = 'Get all the information about all LSP attached',
})

return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Mason for installing language servers
    'mason-org/mason.nvim',
    opts = {},
  },
  {
    -- Useful status updates for LSP
    'j-hui/fidget.nvim',
    opts = {},
  },

  -- Setup native LSP functionality
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @type blink.cmp.Config
    opts = {
      keymap = { preset = 'super-tab', ['<C-y>'] = { 'accept', 'fallback' } },
      appearance = {
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer', 'cmdline' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
    },
    opts_extend = { 'sources.default' },
    config = function(_, opts)
      -- Initialize blink.cmp
      require('blink.cmp').setup(opts)

      -- Enable Vim's native LSP completion
      vim.lsp.completion.enable()

      -- Configure diagnostic display
      -- vim.diagnostic.config {
      --   severity_sort = true,
      --   float = { border = 'rounded', source = 'if_many' },
      --   underline = { severity = vim.diagnostic.severity.ERROR },
      --   signs = vim.g.have_nerd_font and {
      --     text = {
      --       [vim.diagnostic.severity.ERROR] = '󰅚 ',
      --       [vim.diagnostic.severity.WARN] = '󰀪 ',
      --       [vim.diagnostic.severity.INFO] = '󰋽 ',
      --       [vim.diagnostic.severity.HINT] = '󰌶 ',
      --     },
      --   } or {},
      --   virtual_text = {
      --     source = 'if_many',
      --     spacing = 2,
      --     format = function(diagnostic)
      --       local diagnostic_message = {
      --         [vim.diagnostic.severity.ERROR] = diagnostic.message,
      --         [vim.diagnostic.severity.WARN] = diagnostic.message,
      --         [vim.diagnostic.severity.INFO] = diagnostic.message,
      --         [vim.diagnostic.severity.HINT] = diagnostic.message,
      --       }
      --       return diagnostic_message[diagnostic.severity]
      --     end,
      --   },
      -- }

      -- LSP servers setup
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('native-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Load telescope LSP keymaps if available
          local telescope_keymaps_ok, telescope_keymaps = pcall(require, 'custom.plugins.telescope.lsp_keymaps')
          if telescope_keymaps_ok then
            telescope_keymaps.setup_lsp_keymaps(event.buf)
          end

          -- Common LSP keymaps
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Document highlighting
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_group = vim.api.nvim_create_augroup('native-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('native-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'native-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Inlay hints toggle
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.notify('Loading lua LSP config', vim.log.levels.INFO)
      -- Set global configuration for all language servers
      vim.lsp.config('*', {
        -- Default root marker for all LSP servers
        root_markers = { '.git' },
        -- Common capabilities for all servers
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
                commitCharactersSupport = true,
                deprecatedSupport = true,
                tagSupport = {
                  valueSet = { 1 }, -- Deprecated
                },
                preselectSupport = true,
                resolveSupport = {
                  properties = {
                    'documentation',
                    'detail',
                    'additionalTextEdits',
                  },
                },
              },
            },
          },
        },
      })

      -- Enable LSP configurations - these will use the runtime path loaded configurations
      vim.lsp.enable 'lua_ls'
      vim.lsp.enable 'ts_ls'
      vim.lsp.enable 'ruby_ls'
      vim.lsp.enable 'pylsp'
      vim.lsp.enable 'texlab'
      -- Bash {{{
      vim.lsp.config.bashls = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'bash', 'sh', 'zsh' },
        root_markers = { '.git', vim.uv.cwd() },
        settings = {
          bashIde = {
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
          },
        },
      }
      vim.lsp.enable 'bashls'
      -- }}}

      -- Web-dev {{{
      -- TSServer {{{
      vim.lsp.config.ts_ls = {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },

        init_options = {
          hostInfo = 'neovim',
        },
      }
      -- }}}

      -- CSSls {{{
      vim.lsp.config.cssls = {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss' },
        root_markers = { 'package.json', '.git' },
        init_options = {
          provideFormatter = true,
        },
      }
      -- }}}

      -- TailwindCss {{{
      vim.lsp.config.tailwindcssls = {
        cmd = { 'tailwindcss-language-server', '--stdio' },
        filetypes = {
          'ejs',
          'html',
          'css',
          'scss',
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
        },
        root_markers = {
          'tailwind.config.js',
          'tailwind.config.cjs',
          'tailwind.config.mjs',
          'tailwind.config.ts',
          'postcss.config.js',
          'postcss.config.cjs',
          'postcss.config.mjs',
          'postcss.config.ts',
          'package.json',
          'node_modules',
        },
        settings = {
          tailwindCSS = {
            classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
            includeLanguages = {
              eelixir = 'html-eex',
              eruby = 'erb',
              htmlangular = 'html',
              templ = 'html',
            },
            lint = {
              cssConflict = 'warning',
              invalidApply = 'error',
              invalidConfigPath = 'error',
              invalidScreen = 'error',
              invalidTailwindDirective = 'error',
              invalidVariant = 'error',
              recommendedVariantOrder = 'warning',
            },
            validate = true,
          },
        },
      }
      -- }}}

      -- HTML {{{
      vim.lsp.config.htmlls = {
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html' },
        root_markers = { 'package.json', '.git' },

        init_options = {
          configurationSection = { 'html', 'css', 'javascript' },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
          provideFormatter = true,
        },
      }
      -- }}}

      vim.lsp.enable { 'ts_ls', 'cssls', 'tailwindcssls', 'htmlls', 'astro' }
    end,
  },

  { -- Autoformat (kept from original config)
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>F',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 5000,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
      },
      formatters = {
        rubocop = {
          command = 'bundle',
          prepend_args = { 'exec', 'rubocop' },
          args = { '-A', '--stderr', '--stdin', '$FILENAME', '--format', 'quiet' },
          exit_codes = { 0, 1 },
          timeout_ms = 10000,
        },
      },
    },
  },
  { 'windwp/nvim-ts-autotag', dependencies = 'nvim-treesitter/nvim-treesitter', opts = {} },
}
