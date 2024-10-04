return {
    {
        "mfussenegger/nvim-dap", -- Main DAP (Debug Adapter Protocol) plugin
        dependencies = {
            {
                "rcarriga/nvim-dap-ui", -- DAP UI for better debugging experience
                dependencies = {
                    "mfussenegger/nvim-dap", -- Ensure DAP is a dependency
                    "nvim-neotest/nvim-nio", -- Neotest integration for async test running
                    "mfussenegger/nvim-dap-python", -- Python debugging support
                    "theHamsta/nvim-dap-virtual-text", -- Displays virtual text for DAP
                },
            },
        },
        config = function()
            local dap = require("dap")            -- Load dap module
            local dapui = require("dapui")        -- Load dapui module
            local dap_python = require("dap-python") -- Load Python-specific DAP support
            local dapvt = require("nvim-dap-virtual-text") -- Load virtual text module
            dapvt.setup()                         -- Initialize virtual text support

            -- Setup nvim-dap-python with the Conda environment Python path
            dap_python.setup(os.getenv("CONDA_PREFIX") .. "/bin/python")

            -- DAP UI configuration
            dapui.setup()

            -- Automatically open/close dap-ui when debugging starts/stops
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open() -- Open DAP UI when debugging starts
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close() -- Close DAP UI before the debugging session terminates
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close() -- Close DAP UI when exiting the debugging session
            end

            -- Keybindings for dap controls
            vim.keymap.set("n", "<F5>", require("dap").continue, { desc = "Continue debugging" })
            vim.keymap.set("n", "<F10>", require("dap").step_over, { desc = "Step over a line" })
            vim.keymap.set("n", "<F11>", require("dap").step_into, { desc = "Step into a function" })
            vim.keymap.set("n", "<F12>", require("dap").step_out, { desc = "Step out of a function" })
            vim.keymap.set("n", "<Leader>b", require("dap").toggle_breakpoint, { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<Leader>B", require("dap").set_breakpoint, { desc = "Set breakpoint" })
            vim.keymap.set("n", "<Leader>lp", function()
                require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) -- Log point with message
            end, { desc = "Set log point" })
            vim.keymap.set("n", "<Leader>dr", require("dap").repl.open, { desc = "Open REPL" })
            vim.keymap.set("n", "<Leader>dl", require("dap").run_last, { desc = "Run last debug session" })
            vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "Show hover info" })

            -- Keybindings for Python test debugging (unittest, pytest)
            vim.keymap.set("n", "<Leader>dn", require("dap-python").test_method, { desc = "Debug current test method" })
            vim.keymap.set("n", "<Leader>df", require("dap-python").test_class, { desc = "Debug current test class" })

            -- Optional: set 'pytest' as the test runner
            dap_python.test_runner = "pytest"
        end,
    },
}
