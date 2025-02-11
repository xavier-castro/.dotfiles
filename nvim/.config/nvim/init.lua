-- ~/.config/nvim/init.lua

-- Check if running in VSCode
if vim.g.vscode then
  -- Load VSCode-specific config
  require("vscode")
else
  -- Load your regular Neovim config
  require("config.lazy")
end
