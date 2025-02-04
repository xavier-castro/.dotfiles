-- API keys from environment variables
local api_keys = {
  anthropic = os.getenv 'ANTHROPIC_API_KEY',
  openai = os.getenv 'OPENAI_API_KEY',
}

-- Plugin configuration
return {
  {
    'olimorris/codecompanion.nvim',
    cmd = {
      'CodeCompanion',
      'CodeCompanionActions',
      'CodeCompanionChat',
      'CodeCompanionCmd',
    },
    keys = {
      -- Chat operations
      { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'AI Toggle [C]hat' },
      { '<leader>an', '<cmd>CodeCompanionChat<cr>', mode = { 'n', 'v' }, desc = 'AI [N]ew Chat' },
      { 'ga', '<cmd>CodeCompanionChat Add<CR>', mode = { 'v' }, desc = 'AI [A]dd to Chat' },
      -- Actions and prompts
      { '<leader>aa', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'AI [A]ction' },
      { '<leader>ae', '<cmd>CodeCompanion /explain<cr>', mode = { 'v' }, desc = 'AI [E]xplain' },
    },
    opts = {
      strategies = {
        chat = {
          adapter = 'anthropic',
          keymaps = { send = { modes = {} } },
        },
        inline = { adapter = 'copilot' },
      },
      display = {
        chat = { persistent = true },
      },
      opts = { log_level = 'DEBUG' },
      adapters = {
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = { api_key = api_keys.anthropic },
          })
        end,
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = { api_key = api_keys.openai },
          })
        end,
      },
    },
    init = function()
      -- Command alias
      vim.cmd [[cab cc CodeCompanion]]

      -- Initialize custom spinner
      require('xavier.plugins.codecompanion.fidget-spinner'):init()

      -- Auto-format after inline completions
      local group = vim.api.nvim_create_augroup('CodeCompanionHooks', {})
      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = 'CodeCompanionInlineFinished',
        group = group,
        callback = function(request)
          vim.lsp.buf.format { bufnr = request.buf }
        end,
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'echasnovski/mini.diff',
        config = function()
          require('mini.diff').setup {
            source = require('mini.diff').gen_source.none(),
          }
        end,
      },
    },
  },
}
