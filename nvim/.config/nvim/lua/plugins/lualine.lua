return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- local andromeda_lualine = require("andromeda.plugins.lualine")
		--
		-- require("lualine").setup({
		--     options = {
		--         theme = andromeda_lualine.theme,
		--     },
		--     sections = andromeda_lualine.sections,
		--     inactive_sections = andromeda_lualine.inactive_sections,
		-- })
		require("lualine").setup({
			options = {
				-- ... your lualine config
				theme = "tokyonight",
				-- ... your lualine config
			},
		})
	end,
}
