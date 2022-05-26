--------------------------------
-- Core Options
--------------------------------

local opt = vim.opt

-- Decrease update time
opt.timeoutlen = 500
opt.updatetime = 200

-- UI
opt.number = true
opt.relativenumber = true
opt.shortmess:append "c" -- Supress pummenu messages
opt.shortmess:append "I" -- Disable VIM intro
opt.termguicolors = true -- Enable 24-bit RGB color
opt.fillchars = { eob = " " }
opt.showmode = false  -- Don't show the active mode
opt.showcmd = true
opt.cmdheight = 1      -- Height of the command line
opt.laststatus = 3     -- Global status line
opt.winbar = "=%=%m %t" -- (Requires nvim nightly)

-- Indent and Tab Behavior
opt.autoindent = true -- Use indentation of current line on the next one
opt.wrap = true        -- Wrap long lines

opt.expandtab = true  -- Use spaces instead of tabs
opt.shiftwidth = 4    -- Indent with 4 spaces
opt.softtabstop = 4   -- Insert 4 spaces when pressing <Tab>
opt.tabstop = 4

opt.breakindent = true -- Indent wrapped lines
opt.linebreak = true
opt.showbreak = string.rep(" ", 3)
opt.joinspaces = false -- Don't join lines with spaces at the end

-- Better splitting
opt.splitbelow = true -- Split new windows below the current one
opt.splitright = true -- Split new windoes right of the current one

opt.inccommand = "split" -- Show offscreen results in a preview window during :substitute
opt.foldlevelstart = 99
opt.foldmethod = "marker"

-- Searching
opt.ignorecase = true -- Ignore case when searching ..
opt.smartcase = true  -- unless there is a capital letter in the query
opt.incsearch = true  -- Show search results as you type
opt.hlsearch = true   -- Highlight search results

-- Undo, Swap and Backup
opt.backup=false
opt.writebackup=false
opt.dir = vim.fn.stdpath('data') .. '/cache/swap'
opt.undofile = true
opt.undodir = vim.fn.stdpath('data') .. '/cache/undo'

-- Completion
opt.pumheight = 12 -- Only show 12 completion candidates
opt.pumblend = 5   -- Add transparency to the pummenu
opt.completeopt = { "menu", "menuone", "noselect" }

-- Command Line Completion
opt.wildmenu = true
opt.wildignorecase = true
opt.wildcharm = vim.fn.char2nr('^Z') -- Trigger wildcard expansion with <C-z>
opt.wildoptions = "pum"
opt.path:remove("/usr/include")
opt.wildignore:append "*/node_modules/*,*/autoload/*,*/cache/*,*.o,*~,*pycache*"

-- Format Options (:help fo-table)
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto-wrap
  + "c" -- Comments respect textwidth
  + "q" -- Format comments with 'gq'
  - "o" -- Don't continue comments with o and O,
  + "r" -- but do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it. Requires 'autoindent' to be set
  + "j" -- Auto-remove comments if possible.
  - "2" -- Must be removed for '+n'

-- Show the cursor line, but only in normal mode
local group = vim.api.nvim_create_augroup("CursorLine", { clear = true })
local set_cursorline = function(event, value)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end

set_cursorline({ "WinLeave", "InsertEnter" }, false)
set_cursorline({ "BufEnter", "InsertLeave" }, true)

-- Visualize tabs, spaces, unwrapped text and non-breaking spaces
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

-- Use 'rg' for vimgrep
if vim.fn.executable("rg") then
  vim.opt.grepprg = "rg --vimgrep --no-heading --hidden --smart-case --no-ignore-vcs --ignore-file ~/.config/.ignore"
  vim.opt.grepformat = {
    '%f:%l:%c:%m', '%f:%l:%m'
  }
end

-- [Test] Use filetype.lua instead of filetype.vim for performance
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

-- Disable builtin plugins
local builtin_plugins = {
    loaded_gzip              = 1,
    loaded_zip               = 1,
    loaded_zipPlugin         = 1,
    loaded_tar               = 1,
    loaded_tarPlugin         = 1,
    loaded_getscript         = 1,
    loaded_getscriptPlugin   = 1,
    loaded_vimball           = 1,
    loaded_vimballPlugin     = 1,
    loaded_2html_plugin      = 1,
    loaded_matchit           = 1,
    loaded_matchparen        = 1,
    loaded_logiPat           = 1,
    loaded_rrhelper          = 1,
    loaded_netrw             = 1,
    loaded_netrwPlugin       = 1,
    loaded_netrwSettings     = 1,
    loaded_tutor_mode_plugin = 1,
    loaded_rplugin           = 1,
    loaded_bugreport         = 1,
    loaded_syntax            = 1,
    loaded_spellfile_plugin  = 1,
}

for k, v in pairs(builtin_plugins) do
    vim.g[k] = v
end
