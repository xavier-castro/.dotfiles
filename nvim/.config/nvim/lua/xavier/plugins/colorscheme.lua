return { -- neoosolarized
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		opts = {
			disable_background = true,
			disable_italics = true,
		},
	},
    {'Mofiqul/vscode.nvim', lazy=false, opts=function ()
        local c = require('vscode.colors').get_colors()
        require('vscode').setup({
            transparent = true,
        })
    end}
}
