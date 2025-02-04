-- API keys from environment variables
local api_keys = {
  anthropic = os.getenv 'ANTHROPIC_API_KEY',
  openai = os.getenv 'OPENAI_API_KEY',
  deepseek = os.getenv 'DEEPSEEK_API_KEY',
  azure_api = os.getenv 'AZURE_OPENAI_KEY',
  azure_endpoint = os.getenv 'AZURE_OPENAI_ENDPOINT',
  hf = os.getenv 'HF_API_KEY',
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
      display = {
        chat = { persistent = true },
      },
      opts = { log_level = 'DEBUG' },
      adapters = {
        deepseek = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              url = 'https://api.deepseek.com',
              api_key = api_keys.deepseek,
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = 'deepseek' },
        inline = { adapter = 'deepseek' },
        agent = { adapter = 'deepseek' },
      },
    },
    init = function()
      -- Command alias
      vim.cmd [[cab cc CodeCompanion]]

      -- Initialize custom spinner
      -- require('xavier.plugins.codecompanion.fidget-spinner'):init()

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
