return {
  "GeorgesAlkhouri/nvim-aider",
  event = "BufEnter",
  lazy = false,
  cmd = {
    "AiderTerminalToggle", "AiderHealth",
  },
  keys = {
    { "<leader>a/",           "<cmd>AiderTerminalToggle<cr>",    desc = "Open Aider" },
    { "<leader>as",           "<cmd>AiderTerminalSend<cr>",      desc = "Send to Aider",                  mode = { "n", "v" } },
    { "<leader>ac",           "<cmd>AiderQuickSendCommand<cr>",  desc = "Send Command To Aider" },
    { "<leader>ab",           "<cmd>AiderQuickSendBuffer<cr>",   desc = "Send Buffer To Aider" },
    { "<leader><leader><cr>", "<cmd>AiderQuickSendBuffer<cr>",   desc = "Send Buffer to Aider" },
    { "<leader>a+",           "<cmd>AiderQuickAddFile<cr>",      desc = "Add File to Aider" },
    { "<leader>a-",           "<cmd>AiderQuickDropFile<cr>",     desc = "Drop File from Aider" },
    { "<leader>ar",           "<cmd>AiderQuickReadOnlyFile<cr>", desc = "Add File as Read-Only" },
    -- Example nvim-tree.lua integration if needed
    { "<leader>a+",           "<cmd>AiderTreeAddFile<cr>",       desc = "Add File from Tree to Aider",    ft = "NvimTree" },
    { "<leader>a-",           "<cmd>AiderTreeDropFile<cr>",      desc = "Drop File from Tree from Aider", ft = "NvimTree" },
  },
  dependencies = {
    "folke/snacks.nvim",
    "catppuccin/nvim",
    "nvim-tree/nvim-tree.lua",
    "nvim-neo-tree/neo-tree.nvim",
    {
      "MunifTanjim/nui.nvim",
      name = "nui"
    },
    --- Neo-tree integration
    {
      "nvim-neo-tree/neo-tree.nvim",
      config = function()
        require("neo-tree").setup({
          sources = { "filesystem" },

          enable_diagnostics = false,
          enable_git_status = false,

          filesystem = {
            hijack_netrw_behavior = "disabled",
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
          },

          window = {
            mappings = {
              ["<space>"] = "none",
            },
          },

          default_component_configs = {
            name = {
              trailing_slash = true,
              use_git_status_colors = false,
            },
            indent = {
              with_expanders = true,
            },
          },
        })
      end

    },
  },
  config = true,
  opts = {
    aider_cmd = "aider",
    -- Command line arguments passed to aider
    args = {
      "--no-auto-commits",
      "--pretty",
      "--stream",
      "--model gemini/gemini-2.5-pro-exp-03-25",
    },

  }
}
