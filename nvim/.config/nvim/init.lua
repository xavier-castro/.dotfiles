-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
  require("code.lazy")
else
  require("config.lazy")
end
