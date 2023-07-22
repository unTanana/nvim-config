vim.g.mapleader = " ";

vim.keymap.set("n", "<C-w>", '<C-6>')
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

vim.keymap.set("n", "<leader>x", "<cmd>BufDel<CR>");
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>");

-- delete before paste
vim.keymap.set("v", "<leader>p", "\"_dP");
-- delete to _ registry
vim.keymap.set("v", "<leader>d", "\"_d");
vim.keymap.set("n", "<leader>d", "\"_d");

-- Lsp Saga
-- vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>");
-- vim.keymap.set("n", "gs", ":Lspsaga signature_help<CR>");
-- vim.keymap.set("n", "[e", ":Lspsaga diagnostic_jump_prev<CR>");
-- vim.keymap.set("n", ",e", ":Lspsaga diagnostic_jump_next<CR>");
-- vim.keymap.set("n", "<leader>o", ":Lspsaga outline<CR>");

-- c* && c#
vim.keymap.set("n", "c*", "*Ncgn");
vim.keymap.set("n", "c#", "#NcgN");


-- Resize with arrows
vim.keymap.set("n", "<A-Up>", ":resize -2<CR>");
vim.keymap.set("n", "<A-Down>", ":resize +2<CR>");
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>");
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>");

-- QuickFix
vim.keymap.set("n", "]q", ":cnext<CR>");
vim.keymap.set("n", "[q", ":cprev<CR>");
vim.keymap.set("n",   "<C-q>" , ":call QuickFixToggle()<CR>");

-- Terminal window navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h");
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j");
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k");
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l");

-- Better indenting
vim.keymap.set("v", "<", "<gv");
vim.keymap.set("v", ">", ">gv");

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("n", "<A-k>", ":m .+1<CR>==");
vim.keymap.set("n", "<A-j>", ":m .-2<CR>==");
vim.keymap.set("v", "<A-k>", ":m '>+1<CR>gv-gv");
vim.keymap.set("v", "<A-j>", ":m '<-2<CR>gv-gv");
vim.keymap.set("i", "<A-k>", "<Esc>:m .+1<CR>==gi");
vim.keymap.set("i", "<A-j>", "<Esc>:m .-2<CR>==gi");


-- copy pasting + use console logs / errors
vim.keymap.set("n", "<leader>p", "\"0p")
vim.keymap.set("n", "<leader>P>", "\"0P")
vim.keymap.set("n", "<leader>cl", "@l")
vim.keymap.set("n", "<leader>cD", "@o")
vim.keymap.set("n", "<leader>ce", "@k")
