return {
	{
		"nobbmaestro/nvim-andromeda",
		name = "andromeda",
		lazy = false,
		priority = 1000,
		dependencies = {
			"tjdevries/colorbuddy.nvim", -- Add colorbuddy as a dependency
		},
		config = function()
			-- Enable the transparent background
			require("andromeda").setup({
				preset = "andromeda",
				-- transparent_bg = true,
			})
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "EdenEast/nightfox.nvim" },
}
