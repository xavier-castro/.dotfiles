if vim.g.vscode then
else
	local status, colorizer = pcall(require, "colorizer");
	if not status then
		return;
	end;
	colorizer.setup({
		"*"
	});
end;
