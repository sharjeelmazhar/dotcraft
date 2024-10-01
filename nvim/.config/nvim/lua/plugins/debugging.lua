return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"mfussenegger/nvim-dap",
					"nvim-neotest/nvim-nio",
					"mfussenegger/nvim-dap-python",
					"theHamsta/nvim-dap-virtual-text",
				},
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_python = require("dap-python")
			local dapvt = require("nvim-dap-virtual-text")
			dapvt.setup()

			-- Setup nvim-dap-python with the Conda environment Python path
			-- Uses the currently activated Conda environment's Python
			dap_python.setup(os.getenv("CONDA_PREFIX") .. "/bin/python")

			-- DAP UI configuration
			dapui.setup()

			-- Automatically open/close dap-ui when debugging starts/stops
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Keybindings for dap controls
			vim.keymap.set("n", "<F5>", require("dap").continue, {})
			vim.keymap.set("n", "<F10>", require("dap").step_over, {})
			vim.keymap.set("n", "<F11>", require("dap").step_into, {})
			vim.keymap.set("n", "<F12>", require("dap").step_out, {})
			vim.keymap.set("n", "<Leader>b", require("dap").toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>B", require("dap").set_breakpoint, {})
			vim.keymap.set("n", "<Leader>lp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, {})
			vim.keymap.set("n", "<Leader>dr", require("dap").repl.open, {})
			vim.keymap.set("n", "<Leader>dl", require("dap").run_last, {})
			vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, {})

			-- Keybindings for Python test debugging (unittest, pytest)
			vim.keymap.set("n", "<Leader>dn", require("dap-python").test_method, {})
			vim.keymap.set("n", "<Leader>df", require("dap-python").test_class, {})

			-- Optional: set 'pytest' as the test runner
			dap_python.test_runner = "pytest"
		end,
	},
}
