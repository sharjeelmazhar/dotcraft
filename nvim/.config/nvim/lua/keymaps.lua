vim.g.mapleader = " "

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left toggle<CR>", { desc = "Toggle file explorer" })

vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with 'jk'" })
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Move between windows using Ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows using Alt + hjkl
vim.keymap.set("n", "<A-h>", ":vertical resize -10<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-l>", ":vertical resize +10<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<A-j>", ":resize -10<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-k>", ":resize +10<CR>", { desc = "Increase window height" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<Nop>", { desc = "Disable Up arrow key" })
vim.keymap.set("n", "<Down>", "<Nop>", { desc = "Disable Down arrow key" })
vim.keymap.set("n", "<Left>", "<Nop>", { desc = "Disable Left arrow key" })
vim.keymap.set("n", "<Right>", "<Nop>", { desc = "Disable Right arrow key" })

-- Disable arrow keys in visual mode
vim.keymap.set("v", "<Up>", "<Nop>", { desc = "Disable Up arrow key" })
vim.keymap.set("v", "<Down>", "<Nop>", { desc = "Disable Down arrow key" })
vim.keymap.set("v", "<Left>", "<Nop>", { desc = "Disable Left arrow key" })
vim.keymap.set("v", "<Right>", "<Nop>", { desc = "Disable Right arrow key" })

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files using Telescope" })
vim.keymap.set("n", "<leader>of", ":Telescope oldfiles<CR>", { desc = "Find old files using Telescope" })
vim.keymap.set("n", "<leader>lg", ":Telescope live_grep<CR>", { desc = "Live grep using Telescope" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "List buffers using Telescope" })
vim.keymap.set("n", "<leader>fht", ":Telescope help_tags<CR>", { desc = "List help tags using Telescope" })
vim.keymap.set("n", "<leader>lp", ":Telescope lsp_document_symbols<CR>", { desc = "Show LSP document symbols" })

-- LSP commands
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation from language server" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Show implementations" })
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format current buffer" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Show references" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "<leader>td", "<cmd>Telescope diagnostics<cr>", { desc = "List diagnostics using Telescope" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- Git commands
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle blame for current line" })

-- Nvim Tmux navigation
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { desc = "Navigate left in Tmux" })
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { desc = "Navigate down in Tmux" })
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { desc = "Navigate up in Tmux" })
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { desc = "Navigate right in Tmux" })

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end,
})

-- Indent selected lines and keep visual mode active
vim.api.nvim_set_keymap(
    "v",
    "<",
    "<gv",
    { noremap = true, silent = true, desc = "Indent left and stay in visual mode" }
)
vim.api.nvim_set_keymap(
    "v",
    ">",
    ">gv",
    { noremap = true, silent = true, desc = "Indent right and stay in visual mode" }
)

-- Move to the next buffer
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true, desc = "Move to next buffer" })

-- Move to the previous buffer
vim.api.nvim_set_keymap(
    "n",
    "<S-TAB>",
    ":bprevious<CR>",
    { noremap = true, silent = true, desc = "Move to previous buffer" }
)

-- Toggle terminal
vim.keymap.set("n", "<C-/>", ":ToggleTerm<CR>", { desc = "Open/close terminal" })

-- ThePrimeagen keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and maintain cursor position" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search next and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search previous and center" })
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Search and replace current word" }
)

-- Keybindings for vim-test
vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>T", ":TestFile<CR>", { desc = "Run tests in current file" })
vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", { desc = "Run entire test suite" })
vim.keymap.set("n", "<leader>l", ":TestLast<CR>", { desc = "Run last test" })
vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", { desc = "Visit last test run" })

-- Keybinding to run with verbose flag
vim.keymap.set("n", "<leader>va", function()
    -- Temporarily set the pytest options to include -v
    vim.cmd("let test#python#pytest#options = '-v'")
    -- Run the test suite
    vim.cmd("TestSuite")
    -- Reset the pytest options after running
    vim.cmd("let test#python#pytest#options = ''")
end, { desc = "Run test suite with verbose output" })

vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
