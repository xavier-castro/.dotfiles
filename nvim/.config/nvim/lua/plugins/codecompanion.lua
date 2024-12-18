local anthropic_api_key = os.getenv("ANTHROPIC_API_KEY")
local openai_api_key = os.getenv("OPENAI_API_KEY")

vim.api.nvim_set_keymap("n", "<M-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<M-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-.>", "<cmd>CodeCompanion<CR>", { noremap = true, silent = true })

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lua/plenary.nvim", branch = "master" },
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    -- Comment this out if you don't want to setup blink.cmp
    -- {
    -- 	"saghen/blink.cmp",
    -- 	lazy = false,
    -- 	build = "cargo build --release",
    -- 	opts = {
    -- 		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- 		keymap = {
    -- 			preset = "enter",
    -- 			["<S-Tab>"] = { "select_prev", "fallback" },
    -- 			["<Tab>"] = { "select_next", "fallback" },
    -- 		},
    -- 		sources = {
    -- 			completion = {
    -- 				enabled_providers = { "lsp", "path", "buffer", "codecompanion" },
    -- 			},
    -- 			providers = {
    -- 				codecompanion = {
    -- 					name = "CodeCompanion",
    -- 					module = "codecompanion.providers.completion.blink",
    -- 					enabled = true,
    -- 				},
    -- 			},
    -- 		},
    -- 	},
    -- },
  },
  opts = {
    --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
    strategies = {
      --NOTE: Change the adapter as required
      chat = { adapter = "anthropic" },
      inline = { adapter = "copilot" },
    },
    opts = {
      log_level = "DEBUG",
    },
    display = {
      chat = {
        persistent = true, -- Make chat buffers persistent
      },
    },
    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = anthropic_api_key,
          },
        })
      end,
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = openai_api_key,
          },
        })
      end,
    },
  },
}
