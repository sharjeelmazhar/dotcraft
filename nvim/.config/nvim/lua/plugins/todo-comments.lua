return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = true, -- Show icons in the signs column
        sign_priority = 8, -- Sign priority
        keywords = {
            FIX = {
                icon = "󰁨 ", -- Icon used for the sign
                color = "error", -- Color category for FIX
                alt = { "FIXME", "FIXIT", "ISSUE" }, -- Alternative keywords
            },
            BUG = {
                icon = " ", -- Icon used for the BUG keyword
                color = "bug", -- Color category for BUG
                alt = { "BUGFIX", "ERROR" }, -- Alternative keywords for BUG
            },
            TODO = { icon = " ", color = "info" }, -- Using the info color
            HACK = { icon = " ", color = "pink" }, -- Using pink for hacks
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "green", alt = { "INFO" } },
            TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
            fg = "NONE",            -- GUI style for the foreground highlight
            bg = "BOLD",            -- GUI style for the background highlight
        },
        merge_keywords = true,      -- Merge custom keywords with defaults
        highlight = {
            multiline = true,       -- Enable multiline todo comments
            before = "fg",          -- Highlight before the keyword
            keyword = "wide",       -- Highlight the keyword
            after = "fg",           -- Highlight after the keyword
            pattern = [[.*<(KEYWORDS)\s*:]], -- Pattern for highlighting
            comments_only = true,   -- Use treesitter to match keywords in comments only
            max_line_len = 400,     -- Ignore lines longer than this
            exclude = {},           -- List of file types to exclude highlighting
        },
        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#B00020" }, -- Darker Red for FIX
            bug = { "#FF0000" },                            -- Bright Red for BUG
            warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" }, -- Yellow for warnings
            info = { "#FFA500" },                           -- Orange for TODO
            hint = { "DiagnosticHint", "#10B981" },         -- Green for hints
            default = { "Identifier", "#7C3AED" },          -- Purple for defaults
            test = { "#1E90FF" },                           -- Magenta for tests
            pink = { "#FF69B4" },                           -- Pink for HACK
            green = { "#41FC03" },                          -- Pink for HACK
        },
        search = {
            command = "rg", -- Command for searching
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            pattern = [[\b(KEYWORDS):]], -- Regex pattern for matching keywords
        },
    },
}
