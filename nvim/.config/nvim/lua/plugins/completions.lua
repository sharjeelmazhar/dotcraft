return {
    {
        "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    },
    {
        "L3MON4D3/LuaSnip",        -- Snippet engine for Neovim
        dependencies = {
            "saadparwaiz1/cmp_luasnip", -- Completion source for LuaSnip
            "rafamadriz/friendly-snippets", -- Predefined snippets for LuaSnip
        },
    },
    {
        "hrsh7th/nvim-cmp", -- Main completion plugin for Neovim
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load() -- Load VSCode snippets

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- Expand snippets using LuaSnip
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(), -- Set bordered window for completion menu
                    documentation = cmp.config.window.bordered(), -- Set bordered window for documentation
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
                    ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentation down
                    ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion menu
                    ["<C-e>"] = cmp.mapping.abort(),    -- Abort completion
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- Use LSP as a source for completions
                    { name = "luasnip" }, -- Use LuaSnip for snippets
                    { name = "buffer" }, -- Use current buffer for completions
                    { name = "path" }, -- Use file path for completions
                }),
            })
        end,
    },
    {
        "hrsh7th/cmp-buffer", -- Completion source for buffer words
    },
    {
        "hrsh7th/cmp-path", -- Completion source for file paths
    },
    {
        "hrsh7th/cmp-vsnip", -- Completion source for Vsnip snippets
    },
    {
        "hrsh7th/vim-vsnip", -- Snippet engine for Vsnip
    },
}
