vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
if vim.g.vscode then
	require("vscode.vscode-maps")
	require("vscode.vscode-coloring")
else
	require("xavier.config.set")
	require("xavier.config.remap");
	(require("lazy")).setup("xavier.plugins")
end
