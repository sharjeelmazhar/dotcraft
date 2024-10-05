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
					view = "notify", -- The view to use for notifications
					filter = { event = "msg_showmode" }, -- Filter for the event
				},
				{
					view = "notify", -- The view to use for notifications
					filter = { event = "msg_showmode", kind = "mode_change" }, -- Filter out mode change notifications
					opts = { skip = true }, -- Skip displaying these notifications
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
		})
	end,
}
