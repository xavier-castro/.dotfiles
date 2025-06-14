return {
  "MonsieurTib/package-ui.nvim",
  config = function()
    require("package-ui").setup()
    vim.keymap.set("n", "<leader>pu", "<cmd>PackageUI<cr>", { desc = "Open Package UI" })
  end,
}
