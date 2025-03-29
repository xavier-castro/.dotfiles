return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local c = require("vscode.colors").get_colors()
    require("vscode").setup({
      transparent = true,
      group_overrides = {
        CopilotAnnotation = { fg = "#0A0A0A" },
      },
    })
    vim.cmd.colorscheme("vscode")
  end,
}
