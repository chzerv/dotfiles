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
map("n", "<Esc><Esc>", "<cmd> :noh <CR>")

-- Cycle through tabs
map("n", "[t", [[<Cmd>tabprevious<CR>]], opts)
map("n", "]t", [[<Cmd>tabnext<CR>]], opts)

-- Buffer navigation
map("n", "[b", [[<Cmd>bprevious<CR>]], opts)
map("n", "]b", [[<Cmd>bnext<CR>]], opts)

-- Cycle through quickfix items
map("n", "[c", [[<Cmd>cprevious<CR>]], opts)
map("n", "]c", [[<Cmd>cnext<CR>]], opts)
map("n", "<Bslash>c", [[<Cmd>cclose<CR>]], opts)

-- Cycle through location list items
map("n", "[l", [[<Cmd>lprevious<CR>]], opts)
map("n", "]l", [[<Cmd>lnext<CR>]], opts)
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

-- Drag visual selected line(s) vertically and auto-indent
map("x", "mj", ":move'>+<CR>gv=gv", { noremap = true })
map("x", "mk", ":move-2<CR>gv=gv", { noremap = true })

-- Toggle spellcheck
-- The blank string in the mode indicates that this is a 'map' mapping
map("", "<F6>", "<Cmd>setlocal spell! spelllang=en_us<CR>")
map("", "<F7>", "<Cmd>setlocal spell! spelllang=el<CR>")
map("", "<F8>", "<Cmd>setlocal spell! spelllang=en_us,el<CR>")

-- Open a quickfix window with all the terms I last searched for
-- credits to Steve Losh
map("n", "<leader>/", [[<Cmd>execute 'vimgrep /'.@/.'/g %'<CR>copen<CR><CR>nohls<CR>]])

-- Zoom focused split, just like tmux
map("n", "<leader>z", "<Plug>(ToggleZoom)", opts)

-- Substitute the word under cursor...
map("n", "<leader>sl", ":s/<C-R><C-W>//g<left><left>")   -- line wise
map("n", "<leader>sg", ":%s/<C-R><C-W>//g<left><left>")  -- buffer wise

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

map("n", "!", "<cmd>lua require'my_plugins.invert-text'.invert()<cr>", opts)

-- Since we disable netrw, create a binding to replicate "gx"
-- Credits to kutsan
-- map("n", "gx", function()
--     local url = vim.fn.expand("<cfile>")
--     local escaped_url = vim.fn.escape(url, "#%!")
--     cmd(('silent !xdg-open "%s"'):format(escaped_url))
-- end, { silent = true })

-- Neovim Terminal
map({"n", "t" }, "<leader>tv", [[<cmd>lua require'my_plugins.toggle_terminal'.toggle_term("vsplit", 75)<cr>]], opts)
map({"n", "t" }, "<leader>ts", [[<cmd>lua require'my_plugins.toggle_terminal'.toggle_term("split", 15)<cr>]], opts)
map("n", "<leader>tt", "<cmd>tabnew | terminal<cr>", opts)

map("t", "<A-[>", "<C-\\><C-n>", { noremap = true })
map("t", "<A-k>", "<C-\\><C-n><C-w>k", { noremap = true })
map("t", "<A-j>", "<C-\\><C-n><C-w>j", { noremap = true })
map("t", "<A-h>", "<C-\\><C-n><C-w>h", { noremap = true })
map("t", "<A-l>", "<C-\\><C-n><C-w>l", { noremap = true })

-- Command Line Bindings {{{
map("c", "<C-a>", "<Home>", { noremap = true })
map("c", "<C-e>", "<End>", { noremap = true })
