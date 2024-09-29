return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "bashls", "clangd", "yamlls", "ruff_lsp" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.bashls.setup({})
            lspconfig.clangd.setup({})
            lspconfig.yamlls.setup({})
            lspconfig.ruff_lsp.setup({})
        end,
    },
}
