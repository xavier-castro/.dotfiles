return { -- Collection of various small independent pluins/modules
  "echasnovski/mini.nvim",
  config = function()
    -- -- Configure Files with minimal UI
    require("mini.files").setup({
      -- TODO: Set preview to true when done with project to not accidentally review important files
      windows = {
        preview = true,
      },
    })
    vim.keymap.set(
      "n",
      "-",
      ":lua MiniFiles.open()<CR>",
      { noremap = true, silent = true, desc = "MiniFile [E]xplorer" }
    )
  end,
}
