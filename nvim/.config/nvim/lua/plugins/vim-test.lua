return {
    "vim-test/vim-test",
    dependencies = {
        "preservim/vimux",
    },
    config = function()
        -- Set default strategy
        vim.cmd("let test#strategy = 'vimux'")
    end,
}

