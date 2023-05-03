local ls = require("luansip")
ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

require("luasnip.loaders.from_vscode").lazy_load()

local r = require("xavier.utils.remaps")

r.map({ "i", "s" }, "<c-n>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, "Expand current snippet or jump to next", { silent = true })

r.map({ "i", "s" }, "<c-p>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, "Go to previous snippet", { silent = true })

r.map("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, "Show list of options")

-- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
