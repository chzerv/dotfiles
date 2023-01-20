-----------------------------------------------------
-- Core key bindings
-- Plugin specific key bindings are found in the
-- lua/plugins/$plugin_name directory.
-----------------------------------------------------

local g = vim.g
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader and localleader keys
g.mapleader = " "
g.maplocalleader = "\\"

-- Use double ESC to turn off search highlighting
map("n", "<Esc>", "<cmd> :noh <CR>")

-- Cycle through tabs
map("n", "[t", [[<Cmd>tabprevious<CR>]], opts)
map("n", "]t", [[<Cmd>tabnext<CR>]], opts)
map("n", "<C-w><C-t>", "<cmd>tabnew<CR>", opts)
map("n", "<C-w><C-q>", "<cmd>tabclose<CR>", opts)

-- Buffer navigation
map("n", "[b", [[<Cmd>bprevious<CR>]], opts)
map("n", "]b", [[<Cmd>bnext<CR>]], opts)

-- Cycle through quickfix items
map("n", "[q", "<cmd>cprevious<CR>", opts)
map("n", "]q", "<cmd>cnext<CR>", opts)
map("n", "]Q", "<cmd>cfirst<CR>")
map("n", "[Q", "<cmd>clast<CR>")
map("n", "<Bslash>q", [[<Cmd>cclose<CR>]], opts)

-- Cycle through location list items
map("n", "[l", [[<Cmd>lprevious<CR>]], opts)
map("n", "]l", [[<Cmd>lnext<CR>]], opts)
map("n", "]L", "<cmd>lfirst<CR>")
map("n", "[L", "<cmd>llast<CR>")
map("n", "<Bslash>l", [[<Cmd>lclose<CR>]], opts)

-- Allow moving through wrapped lines
map("n", "k", "gk", opts)
map("n", "j", "gj", opts)
map("n", "gk", "k", opts)
map("n", "gj", "j", opts)

-- Put blank lines below/above current line
map("n", "[<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1) <Bar> ']+1<CR>", opts)
map("n", "]<Space>", "<Cmd>put =repeat(nr2char(10), v:count1) <Bar> '[-1<CR>", opts)

-- Re-select block after indenting
map("x", "<", "<gv", opts)
map("x", ">", ">gv", opts)

-- Toggle spellcheck
-- The blank string in the mode indicates that this is a 'map' mapping
map("", "<F6>", "<Cmd>setlocal spell! spelllang=en_us<CR>")
map("", "<F7>", "<Cmd>setlocal spell! spelllang=el<CR>")
map("", "<F8>", "<Cmd>setlocal spell! spelllang=en_us,el<CR>")

-- Autocorrect the last spelling error
map("i", "<C-s>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts)

-- Open a quickfix window with all the terms I last searched for
-- (credits to Steve Losh)
map("n", "<leader>/", [[<Cmd>execute 'vimgrep /'.@/.'/g %'<CR>copen<CR><CR>nohls<CR>]])

-- Zoom focused split, just like tmux
map("n", "<leader>z", "<Plug>(ToggleZoom)", opts)

-- Substitute the word under cursor...
map("n", "<leader>rl", ":s/<C-R><C-W>//g<left><left>") -- line wise
map("n", "<leader>rg", ":%s/<C-R><C-W>//g<left><left>") -- buffer wise

-- Substitute in visual selection
map('x', '<leader>sv', [[:s/\%V]])

-- Avoid clobbering yanked content when pasting in visual mode
-- ref: https://github.com/neovim/neovim/issues/19354
map("x", "p", "P", opts)
map("x", "P", "p", opts)

-- You can also set `vim.opt.clipboard = "unnamedplus"` to have the yank/paste use the system clipboard, but I find that annoying.
map({ "n", "x" }, "<leader>y", [["+y"]], opts)
map("n", "<leader>Y", [["+Y"]], opts)
map({ "n", "x" }, "<leader>p", [["+p"]], opts)
map("n", "<leader>P", [["+P"]], opts)

-- Switch to the directory of the open buffer
map("n", "<leader>cd", "<cmd>lcd %:p:h<CR>:pwd<CR>", opts)

-- "Invert" the word under cursor, e.g., true -> false
map("n", "!", "<cmd>lua require'my_plugins.invert-text'.invert()<cr>", opts)

-- Go to help page of the word under the cursor
map("n", "gh", "yiw:help <C-R><C-W><CR>", opts)

-- Search within visual selection
-- https://www.reddit.com/r/neovim/comments/zy3qq0/til_search_within_visual_selection/
vim.keymap.set('v', '<m-/>', '<esc>/\\%V')

-- Since we disable netrw, create a binding to replicate "gx"
-- Credits to kutsan
-- map("n", "gx", function()
--     local url = vim.fn.expand("<cfile>")
--     local escaped_url = vim.fn.escape(url, "#%!")
--     cmd(('silent !xdg-open "%s"'):format(escaped_url))
-- end, { silent = true })

-- Neovim Terminal
map("n", "<C-\\>", [[<cmd>lua require'my_plugins.term'.toggle_term("split", 15)<cr>]], opts)
map("t", "<C-\\>", "<C-\\><C-n><cmd>lua require'my_plugins.term'.toggle_term('split', 15)<cr>", opts)
map("n", "<leader>tt", "<cmd>lua require'my_plugins.term'.launch_term_in_tab()<cr>", opts)

map("n", "<leader>ts", "<cmd>lua require'my_plugins.term'.send_line_to_term()<cr>", opts)
map("v", "<leader>ts", "<cmd>lua require'my_plugins.term'.send_visual_to_term()<cr>", opts)

map("t", "[t", "<C-\\><C-n><cmd>tabprevious<CR>", opts)
map("t", "]t", "<C-\\><C-n><cmd>tabnext<CR>", opts)

map("t", "<A-[>", "<C-\\><C-n>", { noremap = true })
map("t", "<A-k>", "<C-\\><C-n><C-w>k", { noremap = true })
map("t", "<A-j>", "<C-\\><C-n><C-w>j", { noremap = true })
map("t", "<A-h>", "<C-\\><C-n><C-w>h", { noremap = true })
map("t", "<A-l>", "<C-\\><C-n><C-w>l", { noremap = true })

-- Command Line Bindings
map("c", "<C-a>", "<Home>", { noremap = true })
map("c", "<C-e>", "<End>", { noremap = true })
map("c", "<C-e>", "<End>", { noremap = true })

-- Mimic shell bindings in VIM
map("i", "<C-e>", "<C-o>$")
map("i", "<C-a>", "<C-o>^")
