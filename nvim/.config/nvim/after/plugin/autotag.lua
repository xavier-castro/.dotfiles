if vim.g.vscode then
else
	local status, autotag = pcall(require, "nvim-ts-autotag");
	if not status then
		return;
	end;
	autotag.setup({});
end;
