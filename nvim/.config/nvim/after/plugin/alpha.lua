if vim.g.vscode then
	return
else
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	-- Set header
	dashboard.section.header.val = {
		"                                                     ",
		"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
		"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
		"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
		"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		"                                                     ",
	}

	-- Set menu
	dashboard.section.buttons.val = {
		dashboard.button("R", "🚀  Restore Session", ":SessionManager load_last_session<CR>"),
		dashboard.button("S", "📗  Browse Sessions", ":SessionManager load_session<CR>"),
		dashboard.button("e", "   New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("f", "   Browse Files", ":Telescope fd<CR>"),
		dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
		dashboard.button("s", "   Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
		dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
	}

	-- Send config to alpha
	alpha.setup(dashboard.opts)

	-- Disable folding on alpha buffer
	vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
end