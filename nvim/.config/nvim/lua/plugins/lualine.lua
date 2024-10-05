return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local andromeda_lualine = require("andromeda.plugins.lualine")

		require("lualine").setup({
			options = {
				theme = andromeda_lualine.theme,
			},
			sections = andromeda_lualine.sections,
			inactive_sections = andromeda_lualine.inactive_sections,
			sections = {
				lualine_x = {
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
						color = { fg = "#ff9e64" },
					},
				},
			},
		})
	end,
}
