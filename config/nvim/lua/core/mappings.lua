--------------------------------------------------
--            Core key bindings
-- Plugin specific key bindings are found in
-- the lua/plugins/$plugin_name directory.
--------------------------------------------------

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)
local cmd = vim.cmd
-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader and localleader keys
g.mapleader = " "
g.maplocalleader = "\\"

-- Use double ESC to turn off search highlighting
map("n", "<Esc><Esc>", "<cmd> :noh <CR>")

-- Cycle through tabs
map('n', '[t', [[<Cmd>tabprevious<CR>]], opts)
map('n', ']t', [[<Cmd>tabnext<CR>]], opts)

-- Buffer navigation
map('n', '[b', [[<Cmd>bprevious<CR>]], opts)
map('n', '<leader>bp', [[<Cmd>bprevious<CR>]], opts)
map('n', ']b', [[<Cmd>bnext<CR>]], opts)
map('n', '<leader>bn', [[<Cmd>bnext<CR>]], opts)
map('n', '<leader>bd', "<Cmd>bdelete<CR>", opts)

-- Cycle through quickfix items
map('n', '[c', [[<Cmd>cprevious<CR>]], opts)
map('n', ']c', [[<Cmd>cnext<CR>]], opts)
map('n', '<Bslash>c', [[<Cmd>cclose<CR>]], opts)

-- Cycle through location list items
map('n', '[l', [[<Cmd>lprevious<CR>]], opts)
map('n', ']l', [[<Cmd>lnext<CR>]], opts)
map('n', '<Bslash>l', [[<Cmd>lclose<CR>]], opts)

-- Allow moving through wrapped lines
-- map('n', 'k', [[gk]], opts)
-- map('n', 'j', [[gj]], opts)
-- map('n', 'gk', [[k]], opts)
-- map('n', 'gj', [[j]], opts)

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http<cmd> ://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
-- Stolen from https://github.com/NvChad/NvChad
map({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- Put blank lines below/above current line
map('n', ']<Space>', '<Plug>(PutBlankLinesBelow)', opts)
map('n', '[<Space>', '<Plug>(PutBlankLinesAbove)', opts)

-- Re-select block after indenting
map('x', '<', '<gv', opts)
map('x', '>', '>gv', opts)

-- Toggle spellcheck
-- The blank string in the mode indicates that this is a 'map' mapping
map('', '<F6>', "<Cmd>setlocal spell! spelllang=en_us<CR>")
map('', '<F7>', "<Cmd>setlocal spell! spelllang=el<CR>")
map('', '<F8>', "<Cmd>setlocal spell! spelllang=en_us,el<CR>")

-- Emacs bindings in VIM??
map('i', '<C-a>', '<Esc>I', opts)
map('i', '<C-e>', '<Esc>A', opts)

-- Open a quickfix window with all the terms I last searched for 
-- credits to Steve Losh
map('n', '<leader>/', [[<Cmd>execute 'vimgrep /'.@/.'/g %'<CR>copen<CR><CR>nohls<CR>]])

-- Zoom focused split, just like tmux
map('n', '<leader>z', '<Plug>(ToggleZoom)', opts)

-- Execute current line in command mode
map('n', '<leader>:', '^"zyg_:<C-R>z<CR>', opts)

-- Search for help for the word under the cursor
map('n', '<leader>h', 'viW"zy:help <C-R>z<CR>', opts)

-- Repeat the last command-line command
-- (Ex mode still accesible via gQ)
map('n', 'Q', '@:', opts)

-- Switch to the directory of the open buffer
map('n', '<leader>wd', "<cmd>lcd %:p:h<CR>:pwd<CR>", opts)

map('n', 'sd', "<cmd>ShowDeclaration 0<CR>", { noremap = true })
map('n', 'sD', "<cmd>ShowDeclaration 1<CR>", { noremap = true })

-- map('n', '<leader>e', ":e **/*<C-z><S-Tab>", { noremap = true })
-- map('n', '<leader>f', ":find **/*<C-z><S-Tab>", { noremap = true })

-- Neovim Terminal {{{
map('t', '<A-t>', "<C-\\><C-n><cmd>call archzer#toggle_terminal#ToggleTerminal(10)<CR>", opts)
map('n', '<A-t>', "<cmd>call archzer#toggle_terminal#ToggleTerminal(10)<CR>", opts)
map('t', '<A-[>', '<C-\\><C-n>', { noremap = true })
map('t', '<A-k>', '<C-\\><C-n><C-w>k', { noremap = true })
map('t', '<A-j>', '<C-\\><C-n><C-w>j', { noremap = true })
map('t', '<A-h>', '<C-\\><C-n><C-w>h', { noremap = true })
map('t', '<A-l>', '<C-\\><C-n><C-w>l', { noremap = true })
-- }}}
