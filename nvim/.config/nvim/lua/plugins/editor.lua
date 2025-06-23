-- [[ Editor Enhancement Plugins ]]
-- These plugins enhance the core editing experience

return {
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- "gc" to comment visual regions/lines
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      -- Try to load NvChad nvim-tree config, fallback to basic config
      local ok, nvchad_config = pcall(require, "nvchad.configs.nvimtree")
      if ok then
        return nvchad_config
      else
        -- Basic nvim-tree configuration
        return {
          hijack_cursor = true,
          hijack_netrw = true,
          sync_root_with_cwd = true,
          view = { width = 30 },
          renderer = {
            indent_markers = { enable = true },
            icons = { show = { git = true } },
          },
        }
      end
    end,
  },

  -- Web devicons
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      -- Load devicons theme if base46_cache is available
      if vim.g.base46_cache then
        pcall(dofile, vim.g.base46_cache .. "devicons")
      end

      -- Try to load NvChad devicons, fallback to default if not available
      local ok, nvchad_devicons = pcall(require, "nvchad.icons.devicons")
      if ok then
        return { override = nvchad_devicons }
      else
        return {}
      end
    end,
  },


  -- Which-key for keybinding help
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      -- Load whichkey theme if base46_cache is available
      if vim.g.base46_cache then
        pcall(dofile, vim.g.base46_cache .. "whichkey")
      end
      return {}
    end,
    config = function(_, opts)
      require("which-key").setup(opts)

      -- Document existing key chains using new which-key v3 spec
      require("which-key").add {
        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>w_", hidden = true },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>t_", hidden = true },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
        { "<leader>h_", hidden = true },
      }
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      -- Try to load NvChad gitsigns config, fallback to basic config
      local ok, nvchad_config = pcall(require, "nvchad.configs.gitsigns")
      if ok then
        return nvchad_config
      else
        -- Basic gitsigns configuration
        return {
          signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
          },
        }
      end
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)

      -- Add git hunk navigation keymaps
      vim.keymap.set("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal { "]c", bang = true }
        else
          require("gitsigns").nav_hunk "next"
        end
      end, { desc = "Jump to next git [H]unk" })

      vim.keymap.set("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal { "[c", bang = true }
        else
          require("gitsigns").nav_hunk "prev"
        end
      end, { desc = "Jump to previous git [H]unk" })

      -- Actions
      vim.keymap.set("v", "<leader>hs", function()
        require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
      end, { desc = "Stage git hunk" })
      vim.keymap.set("v", "<leader>hr", function()
        require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" }
      end, { desc = "Reset git hunk" })

      vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk, { desc = "Git [s]tage hunk" })
      vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk, { desc = "Git [r]eset hunk" })
      vim.keymap.set("n", "<leader>hS", require("gitsigns").stage_buffer, { desc = "Git [S]tage buffer" })
      vim.keymap.set("n", "<leader>hu", require("gitsigns").undo_stage_hunk, { desc = "Git [u]ndo stage hunk" })
      vim.keymap.set("n", "<leader>hR", require("gitsigns").reset_buffer, { desc = "Git [R]eset buffer" })
      vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { desc = "Git [p]review hunk" })
      vim.keymap.set("n", "<leader>hb", function()
        require("gitsigns").blame_line { full = false }
      end, { desc = "Git [b]lame line" })
      vim.keymap.set("n", "<leader>hd", require("gitsigns").diffthis, { desc = "Git [d]iff against index" })
      vim.keymap.set("n", "<leader>hD", function()
        require("gitsigns").diffthis "@"
      end, { desc = "Git [D]iff against last commit" })

      -- Toggles
      vim.keymap.set(
        "n",
        "<leader>tb",
        require("gitsigns").toggle_current_line_blame,
        { desc = "[T]oggle git show [b]lame line" }
      )
      vim.keymap.set("n", "<leader>tD", require("gitsigns").toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
    end,
  },
}
