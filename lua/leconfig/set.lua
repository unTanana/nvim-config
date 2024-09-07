vim.opt.relativenumber = true
vim.opt.spelloptions = "camel"
vim.opt.incsearch = true
vim.opt.nu = true

vim.opt.isfname = vim.opt.isfname:append("@-@")

vim.opt.backup = false            -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1             -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0          -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"    -- the encoding written to a file
vim.opt.foldmethod = "manual"     -- folding, set to "expr" for treesitter based folding
vim.opt.foldexpr = ""             -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true             -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true           -- highlight all matches on previous search pattern
vim.opt.ignorecase = true         -- ignore case in search patterns
vim.opt.mouse = "a"               -- allow the mouse to be used in neovim
vim.opt.pumheight = 10            -- pop up menu height
vim.opt.showmode = false          -- we don't need to see things like -- INSERT -- anymore
vim.opt.smartcase = true          -- smart case
vim.opt.splitbelow = true         -- force all horizontal splits to go below current window
vim.opt.splitright = true         -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false          -- creates a swapfile
vim.opt.termguicolors = true      -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000         -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true              -- set the title of window to the value of the titlestring
vim.opt.undofile = true           -- enable persistent undo
vim.opt.updatetime = 100          -- faster completion
vim.opt.writebackup = false       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true          -- convert tabs to spaces
vim.opt.shiftwidth = 4            -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4               -- insert 4 spaces for a tab
vim.opt.cursorline = true         -- highlight the current line
vim.opt.number = true             -- set numbered lines
vim.opt.numberwidth = 4           -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"        -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false              -- display lines as one long line
vim.opt.scrolloff = 8             -- minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 8         -- minimal number of screen lines to keep left and right of the cursor.
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.laststatus = 3

-- additional filetypes
vim.filetype.add({
    extension = {
        templ = "templ",
        heex = "heex",
    },
})
