--------------------------------
-- Core settings
--------------------------------
local opt = vim.opt

opt.hidden = true -- Change buffers even when unsaved buffers exist
opt.number = true
opt.shortmess:append 'c' -- Supress messages when reaching end of pummenu
opt.relativenumber = true
opt.splitbelow = true -- Split new windows below the current one
opt.splitright = true -- Split new windoes right of the current one
opt.ignorecase = true -- Ignore case when searching ..
opt.smartcase = true  -- unless there is a capital letter in the query
opt.incsearch = true  -- Show search results as you type
opt.hlsearch = true   -- Highlight search results
opt.showmode = false  -- Don't show the active mode
opt.showcmd = true
opt.cmdheight = 1     -- Height of the command line
opt.mouse = n         -- Mouse support, in normal mode (change to 'a' for all modes)
opt.laststatus = 3    -- Global status line
opt.inccommand = "split" -- Show offscreen results in a preview window during :substitute
opt.foldlevelstart = 99
opt.foldmethod = "marker"

-- Completion {{{
opt.pumheight = 12 -- Only show 12 completion candidates
-- opt.pumblend = 15 -- Add some transparency to the pummenu
opt.completeopt = { "menu", "menuone", "noselect" }


-- Command Line Completion
opt.wildmenu = true
opt.wildignorecase = true
opt.wildcharm = vim.fn.char2nr('^Z') -- Trigger wildcard expansion with <C-z>
opt.wildoptions = "pum"
opt.path:remove("/usr/include")
opt.wildignore:append "*/node_modules/*,*/autoload/*,*/cache/*,*.o,*~,*pycache*"
-- }}}

-- Indent and Tab Behavior {{{
opt.autoindent = true -- Use indentation of current line on the next one
opt.expandtab = true  -- Use spaces instead of tabs
opt.shiftwidth = 4    -- Indent with 4 spaces
opt.softtabstop = 4    -- Insert 4 spaces when pressing <Tab>
opt.wrap = true        -- Wrap long lines
opt.breakindent = true -- Indent wrapped lines
opt.linebreak = true
-- opt.showbreak = '↳'
opt.showbreak = string.rep(" ", 3)
opt.joinspaces = false -- Don't join lines with spaces at the end
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

-- Cursor line {{{
-- Enable the cursor line, but only show it in normal mode
opt.cursorline = true

local set_cursorline = function(event, value)
    vim.api.nvim_create_autocmd(event, {
        group = vim.api.nvim_create_augroup("CursorLine", { clear = true }),
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end

set_cursorline({ "WinLeave", "InsertEnter" }, false)
set_cursorline({ "BufEnter", "InsertLeave" }, true)
-- }}}

-- Visualize tabs, spaces, unwrapped text and non-breaking spaces {{{
opt.list = true
opt.listchars = {
    extends = '›',
    precedes = '‹',
    nbsp = '␣',
    tab = '» '
}

-- Don't show trailing whitespaces in insert mode
vim.cmd([[
    augroup ListcharsTrail
        autocmd!
        autocmd InsertEnter * :set listchars-=trail:•
        autocmd InsertLeave * :set listchars+=trail:•
    augroup END
]])
-- }}}
