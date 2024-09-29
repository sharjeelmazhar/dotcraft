return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			size = 20, -- This is ignored in float mode
			open_mapping = [[<c-t>]], -- Keybinding to toggle the terminal
			direction = "float", -- Opens the terminal in float mode
			float_opts = {
				border = "curved", -- You can also use 'single', 'double', 'shadow', etc.
				winblend = 3, -- Transparency of the floating window
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
			close_on_exit = true, -- Close terminal when the process exits
			shell = vim.o.shell, -- Shell to use (default is your system's shell)
		})
	end,
}
