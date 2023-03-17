require("copilot").setup({
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-l>",
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-r>",
      next = "<M->>",
      prev = "<M-<>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node", -- Node version must be < 18
  server_opts_overrides = {},
})

vim.api.nvim_set_keymap("n", "<leader>cp", ":Copilot panel toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cs", ":Copilot suggestion toggle_auto_trigger<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cc", ":ChatGPT<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cm", ":ChatGPTActAs<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ce", ":ChatGPTEditWithInstructions<cr>", { noremap = true, silent = true })
