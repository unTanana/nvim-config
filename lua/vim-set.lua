vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
-- vim.wo.number = true


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

local function organize_imports()
    -- get current file extension
    local ext = vim.fn.expand("%:e")

    -- if python
    if ext == "py" then
        -- run isort
        vim.cmd("silent Isort")
    end

    if ext == "js" or ext == "ts" or ext == "jsx" or ext == "tsx" or ext == "astro" then
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = ""
        }
        vim.lsp.buf.execute_command(params)
    end
end



vim.g.mapleader = " ";

vim.keymap.set("n", "<leader>Lc", "<cmd>edit ~/.config/nvim/init.lua<CR>");


vim.keymap.set("n", "<leader>co", organize_imports);

vim.keymap.set('n', '<C-Tab>', '<C-^>')
vim.keymap.set("n", "<C-s>", ":w<cr>");
vim.keymap.set("i", "<C-s>", "<ESC>:w<cr>a");
vim.keymap.set("n", "<S-CR>", "o<ESC>")
vim.keymap.set("i", "<S-CR>", "<ESC>o");
vim.keymap.set("v", "y", "ygv<ESC>"); -- visual_mode yank -> moves cursor to end of yanked text and into normal mode
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("i", "jk", "<ESC>");
vim.keymap.set("n", "YY", "va{Vygv<ESC>")
vim.keymap.set("n", "<leader>DD", 'vi{"_d')
vim.keymap.set("n", "gI", ":vsplit | norm gi<CR>")
vim.keymap.set("n", "gs", ":vsplit | norm gd<CR>")

vim.keymap.set("n", "<leader>x", "<cmd>q<CR>");
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>");

-- delete before paste
vim.keymap.set("v", "<leader>p", "\"_dP");
-- delete to _ registry
vim.keymap.set("v", "<leader>d", "\"_d");
vim.keymap.set("n", "<leader>d", "\"_d");
vim.keymap.set("n", "<leader>cp", "\"0p");
vim.keymap.set("n", "<leader>cP", "\"0P");
vim.keymap.set("v", "<leader>cp", "\"0p");
vim.keymap.set("v", "<leader>cP", "\"0P");

-- c* && c#
vim.keymap.set("n", "c*", "*Ncgn");
vim.keymap.set("n", "c#", "#NcgN");

-- gitk
vim.keymap.set("n", "<leader>cg", ":!gitk %<CR>");


-- Resize with arrows
vim.keymap.set("n", "<A-Up>", ":resize -2<CR>");
vim.keymap.set("n", "<A-Down>", ":resize +2<CR>");
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>");
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>");

-- QuickFix
vim.keymap.set("n", "]q", ":cnext<CR>");
vim.keymap.set("n", "[q", ":cprev<CR>");
vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>");

-- -- Terminal window navigation
-- vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h");
-- vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j");
-- vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k");
-- vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l");

-- Better indenting
vim.keymap.set("v", "<", "<gv");
vim.keymap.set("v", ">", ">gv");

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true });
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true });
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv-gv", { silent = true });
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv-gv", { silent = true });
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true });
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true });


-- copy pasting + use console logs / errors
vim.keymap.set("n", "<leader>p", "\"0p")
vim.keymap.set("n", "<leader>P>", "\"0P")
vim.keymap.set("n", "<leader>cl", "@l")
vim.keymap.set("n", "<leader>cD", "@o")
vim.keymap.set("n", "<leader>ce", "@k")
