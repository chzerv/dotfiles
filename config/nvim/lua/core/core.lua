--------------------------------
-- Core settings
--------------------------------

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

opt.hidden = true -- Change buffers even when unsaved buffers exist
opt.number = true
opt.relativenumber = true
opt.splitbelow = true -- Split new windows below the current one
opt.splitright = true -- Split new windoes right of the current one
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.clipboard = "unnamedplus" -- Use the primary clipboard for yank/paste
opt.mouse = "a"
-- Make substitutions (:s///) interactive. "split" creates a preview window
-- with any out-of-screen changes
opt.inccommand = "split"

-- Indent and tab behavior {{{
opt.autoindent = true -- Use indentation of previous line on new line
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Indent with 4 spaces
opt.softtabstop = 4 -- Insert 4 spaces when pressing <Tab>
--- }}}

-- Backspace behavior {{{
opt.backspace:append "eol"
opt.backspace:append "indent"
opt.backspace:append "start"
-- }}}

-- Backup, swap and undo files {{{
opt.backup=false
opt.writebackup=false
opt.dir = vim.fn.stdpath('data') .. '/cache/swap'
if vim.fn.has('persistent_undo') == 1 then
    opt.undofile = true
    opt.undodir = vim.fn.stdpath('data') .. '/cache/undo'
end
-- }}}

-- Auto-completion {{{
opt.completeopt:append "noinsert"
opt.completeopt:append "menuone"
opt.completeopt:append "preview"
opt.complete = ".,w,b,i,u,t"
-- }}}

-- Command line completioin {{{
opt.wildmenu = true
opt.wildignorecase = true
opt.wildcharm = vim.fn.char2nr('^Z') -- wildcharm expects a number, so we convert <C-z> to a number
opt.wildoptions = "pum"
opt.path:remove("/usr/include")
opt.wildignore:append "*/node_modules/*,*/autoload/*,*/cache/*,*.o,*~,*pycache*"
-- }}}

-- Line movement, wrap etc {{{
opt.wrap = true
opt.linebreak = true
if vim.fn.has('linebreak') == 1 then
    vim.o.showbreak = '↳'
end
opt.joinspaces = false -- Don't join lines with spaces at the end
opt.breakindent = true -- Indent wrapped lines
-- }}}

-- Disable builtin plugins

g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_man = 1
g.loaded_remote_plugins = 1
g.loaded_shada_plugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_tutor_mode_plugin= 1
