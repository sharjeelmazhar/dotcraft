vim.g.mapleader = " "

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left toggle<CR>", { desc = "show/hide file explorer" })

vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Move between windows using Ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize windows using Alt + hjkl
vim.keymap.set("n", "<A-h>", ":vertical resize -10<CR>")
vim.keymap.set("n", "<A-l>", ":vertical resize +10<CR>")
vim.keymap.set("n", "<A-j>", ":resize -10<CR>")
vim.keymap.set("n", "<A-k>", ":resize +10<CR>")

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")

-- Disable arrow keys in insert mode
-- vim.keymap.set('i', '<Up>', '<Nop>')
-- vim.keymap.set('i', '<Down>', '<Nop>')
-- vim.keymap.set('i', '<Left>', '<Nop>')
-- vim.keymap.set('i', '<Right>', '<Nop>')

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>of", ":Telescope oldfiles<CR>", { desc = "Telescope find old files" })
vim.keymap.set("n", "<leader>lg", ":Telescope live_grep<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fht", ":Telescope help_tags<CR>", { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>lp", ":Telescope lsp_document_symbols<CR>", { desc = "Telescope lsp document symbols" })

-- lsp
-- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
-- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

-- bashbunni and tj

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "show hover documentation from language server" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, {})
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "<leader>td", "<cmd>Telescope diagnostics<cr>", {})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})

-- git stuff
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})

-- nvim tmux navigation
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end,
})

-- Indent selected lines and keep visual mode active
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Move to the next buffer
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })

-- Move to the previous buffer
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- Toggleterm
-- vim.keymap.set("n", "<C-/>", ":ToggleTerm<CR>", { desc = "Open/close terminal" })
-- vim.keymap.set("n", "<C-,>", "<Cmd>ToggleTerm<CR>", {})

-- theprimeagen keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", '"_dP')
-- vim.keymap.set("n", "<leader>y", '"+y')
-- vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
