return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
			cmdline = {
				enabled = true, -- Ensure cmdline is enabled
				view = "cmdline", -- Use the default cmdline view
				opts = {
					position = { relative = "editor", row = 0.5, col = 0.5 }, -- Center the popup
					size = { width = 50, height = 1 }, -- Set size as needed
					border = {
						style = "rounded", -- You can use "rounded", "solid", "none", etc.
						highlight = "FloatBorder", -- Highlight group for the border
					},
					title = "Command Line", -- Title for the popup
				},
			},
		})
	end,
}
