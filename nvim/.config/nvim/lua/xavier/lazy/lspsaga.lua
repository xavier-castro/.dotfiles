return {
  "nvimdev/lspsaga.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
  config = function()
    require("lspsaga").setup({
      ui = {
        border = "single",
      },
      lightbulb = {
        enable = false,
        sign = false,
      },
      code_action = { extend_gitsigns = false, num_shortcut = true },
      diagnostic = {
        show_layout = "float",
        max_height = 0.8,
        max_width = 0.1,
        keys = {
          quit = { "q", "<ESC>" },
        },
      },
    })
    vim.keymap.set("n", "<S-r>", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show hover doc" })
    vim.keymap.set("n", "<leader>ol", "<cmd>Lspsaga outline<CR>", { desc = "Show outline" })
    vim.keymap.set("n", "<C-c>d", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek definition" })
    vim.keymap.set("n", "<C-c>t", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "Peek type definition" })

    vim.keymap.set("n", "[d", function()
      require("lspsaga.diagnostic"):goto_prev()
    end, { desc = "Previous diagnostic" })

    vim.keymap.set("n", "]d", function()
      require("lspsaga.diagnostic"):goto_next()
    end, { desc = "Next diagnostic" })

    vim.keymap.set("n", "[e", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Previous error" })

    vim.keymap.set("n", "]e", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Next error" })
    -- Lspsaga
  end,
}
