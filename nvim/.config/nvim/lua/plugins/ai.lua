-- -- https://github.com/olimorris/codecompanion.nvim/discussions/972
-- local venice_api_key = os.getenv("VENICE_API_KEY")
--
-- return {
--   "olimorris/codecompanion.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-treesitter/nvim-treesitter",
--   },
--   config = function()
--     require("codecompanion").setup({
--       adapters = {
--         venice = function()
--           return require("codecompanion.adapters").extend("openai_compatible", {
--             name = "venice",
--             formatted_name = "Venice",
--             roles = {
--               llm = "assistant",
--               user = "user",
--             },
--             opts = {
--               stream = true,
--             },
--             features = {
--               text = true,
--               tokens = true,
--               vision = false,
--             },
--             env = {
--               url = "https://api.venice.ai/api",
--               chat_url = "/v1/chat/completions",
--               -- api_key = "",  <-- get from sys env: OPENAI_API_KEY
--               api_key = venice_api_key,
--             },
--             schema = {
--               model = {
--                 default = "deepseek-r1-671b",
--                 -- Other models available:
--                 --   llama-3.1-405b
--                 --   llama-3.2-3b
--                 --   llama-3.3-70b
--                 --   dolphin-2.9.2-qwen2-72b
--                 --   deepseek-r1-llama-70b
--                 --   deepseek-r1-671b
--                 --   qwen2.5-coder-32b
--                 --   qwen-2.5-vl
--               },
--               temperature = {
--                 order = 2,
--                 mapping = "parameters",
--                 type = "number",
--                 optional = true,
--                 default = 0.8,
--                 desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
--                 validate = function(n)
--                   return n >= 0 and n <= 2, "Must be between 0 and 2"
--                 end,
--               },
--               max_completion_tokens = {
--                 order = 3,
--                 mapping = "parameters",
--                 type = "integer",
--                 optional = true,
--                 default = nil,
--                 desc = "An upper bound for the number of tokens that can be generated for a completion.",
--                 validate = function(n)
--                   return n > 0, "Must be greater than 0"
--                 end,
--               },
--               presence_penalty = {
--                 order = 4,
--                 mapping = "parameters",
--                 type = "number",
--                 optional = true,
--                 default = 0,
--                 desc = "Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.",
--                 validate = function(n)
--                   return n >= -2 and n <= 2, "Must be between -2 and 2"
--                 end,
--               },
--               top_p = {
--                 order = 5,
--                 mapping = "parameters",
--                 type = "number",
--                 optional = true,
--                 default = 0.9,
--                 desc = "A higher value (e.g., 0.95) will lead to more diverse text, while a lower value (e.g., 0.5) will generate more focused and conservative text. (Default: 0.9)",
--                 validate = function(n)
--                   return n >= 0 and n <= 1, "Must be between 0 and 1"
--                 end,
--               },
--               stop = {
--                 order = 6,
--                 mapping = "parameters",
--                 type = "string",
--                 optional = true,
--                 default = nil,
--                 desc = "Sets the stop sequences to use. When this pattern is encountered the LLM will stop generating text and return. Multiple stop patterns may be set by specifying multiple separate stop parameters in a modelfile.",
--                 validate = function(s)
--                   return s:len() > 0, "Cannot be an empty string"
--                 end,
--               },
--               frequency_penalty = {
--                 order = 8,
--                 mapping = "parameters",
--                 type = "number",
--                 optional = true,
--                 default = 0,
--                 desc = "Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.",
--                 validate = function(n)
--                   return n >= -2 and n <= 2, "Must be between -2 and 2"
--                 end,
--               },
--               logit_bias = {
--                 order = 9,
--                 mapping = "parameters",
--                 type = "map",
--                 optional = true,
--                 default = nil,
--                 desc = "Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.",
--                 subtype_key = {
--                   type = "integer",
--                 },
--                 subtype = {
--                   type = "integer",
--                   validate = function(n)
--                     return n >= -100 and n <= 100, "Must be between -100 and 100"
--                   end,
--                 },
--               },
--             },
--           })
--         end,
--       },
--       strategies = {
--         agent = { adapter = "venice" },
--         chat = { adapter = "anthropic" },
--         inline = { adapter = "anthropic" },
--       },
--     })
--     vim.keymap.set({ "n", "v" }, "<M-g>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
--     vim.keymap.set(
--       { "n", "v" },
--       "<LocalLeader>a",
--       "<cmd>CodeCompanionChat Toggle<cr>",
--       { noremap = true, silent = true }
--     )
--     vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
--
--     -- Expand 'cc' into 'CodeCompanion' in the command line
--     vim.cmd([[cab cc CodeCompanion]])
--   end,
-- }
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    -- add any opts here
    -- for example
    provider = "openai",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- timeout in milliseconds
      temperature = 0, -- adjust if needed
      max_tokens = 4096,
      -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}
