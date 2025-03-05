function ColorMyPencils(color)
	color = color or "256_noir"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	-- lazy
	{
		"askfiy/visual_studio_code",
		priority = 100,
		opts = {},
	},
	{
		"craftzdog/solarized-osaka.nvim",
		priority = 1000,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})

			-- ColorMyPencils();
		end,
	},
}
