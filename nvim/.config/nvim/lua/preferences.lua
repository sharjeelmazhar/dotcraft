-- Disable 'ro' (read-only) option for all file types
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Enable relative line numbers
vim.opt.relativenumber = true -- Show line numbers relative to the cursor position
vim.opt.number = true -- Show absolute line numbers

-- Configure indentation settings
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 4 -- Set the number of spaces a tab counts for
vim.opt.shiftwidth = 4 -- Set the number of spaces used for each step of (auto)indent

-- Disable line wrapping
vim.opt.wrap = true -- Prevent lines from wrapping to the next line
vim.opt.linebreak = true -- Break lines at convenient points

-- Highlight the line where the cursor is located
vim.opt.cursorline = true -- Enable highlighting of the current line

-- Set scroll offset to keep context while navigating
vim.opt.scrolloff = 10 -- Number of lines to keep above and below the cursor when scrolling

-- Configure search behavior
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override 'ignorecase' if search contains uppercase letters

-- Enable mouse support in all modes
vim.o.mouse = "a" -- Allow mouse usage in all modes (normal, visual, insert, etc.)

-- Set time for waiting for a command to trigger events
vim.opt.updatetime = 50 -- Time in milliseconds for triggering events, e.g., CursorHold

-- Optional settings (uncomment to enable)
-- vim.opt.colorcolumn = "79"    -- Set a color column at 79 characters (useful for line length limit)
-- vim.opt.clipboard = "unnamedplus" -- Use the system clipboard for all operations
