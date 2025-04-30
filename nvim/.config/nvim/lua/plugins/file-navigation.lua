return {
  {
    "cbochs/grapple.nvim",
    opts = {
      scope = "git", -- also try out "git_branch"
      icons = false, -- setting to "true" requires "nvim-web-devicons"
      status = false,
    },
    keys = {
      { "<leader><leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
      { "<c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

      { "<c-h>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
      { "<c-t>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
      { "<c-n>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
      { "<c-s>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

      { "<c-s-n>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
      { "<c-s-p>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return vim.startswith(name, ".DS_Store")
        end,
      },
      keymaps = {
        ["<C-h>"] = false, -- Split
        ["<C-l>"] = false, -- refresh
        ["<leader>os"] = "actions.select_split",
        ["<leader>ov"] = "actions.select_vsplit",
        ["<C-g>"] = "actions.refresh",
      },
      float = { padding = 4 },
    },
    config = function(_, opts)
      local oil = require("oil")
      oil.setup(opts)
      vim.keymap.set("n", "-", oil.open, {})
    end,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "OXY2DEV/markview.nvim" },
    config = function()
      local nvimtree = require("nvim-tree")

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      nvimtree.setup({
        diagnostics = {
          enable = false,
          show_on_dirs = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        view = {
          side = "right",
          width = 35,
          relativenumber = true,
        },
        renderer = {
          indent_markers = {
            enable = false,
          },
        },
        filters = {
          custom = {},
        },
        git = {
          ignore = false,
        },
      })
    end,
    keys = {
      {
        "<leader>ee",
        ":NvimTreeToggle<CR>",
        mode = { "n" },
        desc = "Toggle file explorer",
      },
      {
        "<leader>ef",
        ":NvimTreeFindFileToggle<CR>",
        mode = { "n" },
        desc = "Toggle file explorer on current file",
      },
      {
        "<leader>ec",
        ":NvimTreeCollapse<CR>",
        mode = { "n" },
        desc = "Collapse file explorer",
      },
      {
        "<leader>er",
        ":NvimTreeRefresh<CR>",
        mode = { "n" },
        desc = "Refresh file explorer",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "OXY2DEV/markview.nvim" },
    config = function()
      local nvimtree = require("nvim-tree")

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      nvimtree.setup({
        diagnostics = {
          enable = false,
          show_on_dirs = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        view = {
          side = "right",
          width = 35,
          relativenumber = true,
        },
        renderer = {
          indent_markers = {
            enable = false,
          },
        },
        filters = {
          custom = {},
        },
        git = {
          ignore = false,
        },
      })
    end,
    keys = {
      {
        "<leader>ee",
        ":NvimTreeToggle<CR>",
        mode = { "n" },
        desc = "Toggle file explorer",
      },
      {
        "<leader>ef",
        ":NvimTreeFindFileToggle<CR>",
        mode = { "n" },
        desc = "Toggle file explorer on current file",
      },
      {
        "<leader>ec",
        ":NvimTreeCollapse<CR>",
        mode = { "n" },
        desc = "Collapse file explorer",
      },
      {
        "<leader>er",
        ":NvimTreeRefresh<CR>",
        mode = { "n" },
        desc = "Refresh file explorer",
      },
    },
  },
}
