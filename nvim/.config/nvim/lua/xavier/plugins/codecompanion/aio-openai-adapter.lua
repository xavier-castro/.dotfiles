local azure_api_key = os.getenv 'AZURE_API_KEY'
local M = {}

local config = {
  name = 'aio_openai',
  formatted_name = 'AiO OpenAI',
  env = {
    api_key = azure_api_key, -- TODO: move to secret store
    endpoint = 'https://xc-azure-openai.openai.azure.com/openai/deployments/gpt-4o/chat/completions?api-version=2024-08-01-preview',
  },
  schema = {
    model = {
      default = 'gpt-4o',
      choices = {
        'gpt-4o',
        'gpt-4o-mini',
        ['o1-preview'] = { opts = { stream = false } },
      },
    },
  },
}

M.make = function()
  return require('codecompanion.adapters').extend('azure_openai', config)
end

return M
