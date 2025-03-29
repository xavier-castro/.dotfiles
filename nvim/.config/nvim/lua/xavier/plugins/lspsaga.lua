return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        enable = true,
      },
      ui = {
        border = "rounded",
      },
    })

    -- LSP keymaps using lspsaga
    vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "[G]oto [D]efinition" })
    vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", { desc = "[G]oto [R]eferences" })
    vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { desc = "[G]oto [D]eclaration" })
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Documentation" })
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "[C]ode [A]ction" })
    vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "[R]e[n]ame" })
    vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "[D]iagnostics Line" })
    vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "[D]iagnostics Cursor" })
    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Previous [D]iagnostic" })
    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next [D]iagnostic" })
    vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "[O]utline" })
  end,
}
