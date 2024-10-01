return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	vim.keymap.set("n", "<leader>t", ":TestNearest<CR>"),
	vim.keymap.set("n", "<leader>T", ":TestFile<CR>"),
	vim.keymap.set("n", "<leader>a", ":TestSuite<CR>"),
	vim.keymap.set("n", "<leader>l", ":TestLast<CR>"),
	vim.keymap.set("n", "<leader>g", ":TestVisit<CR>"),

	-- Set default strategy
	vim.cmd("let test#strategy = 'vimux'"),

	-- Add keybinding to run with verbose flag
	vim.keymap.set("n", "<leader>va", function()
		-- Temporarily set the pytest options to include -v
		vim.cmd("let test#python#pytest#options = '-v'")
		-- Run the test suite
		vim.cmd("TestSuite")
		-- Reset the pytest options after running
		vim.cmd("let test#python#pytest#options = ''")
	end),
}
