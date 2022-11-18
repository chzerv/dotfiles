--------------------------------
-- Core Options
--------------------------------

local opt = vim.opt

-- General
opt.updatetime = 100
opt.scrolloff = 4

-- UI
opt.number = true
opt.relativenumber = true
opt.shortmess:append("cs")
opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 3 -- Global status line
opt.termguicolors = true
opt.signcolumn = "yes" -- Avoid shifting the screen whenever a diagnostic appears
opt.diffopt:append({ "linematch:60" })
-- opt.winbar = "=%=%m %t"

-- Indent and Tab Behavior
opt.autoindent = true -- Use indentation of current line on the next one
opt.wrap = true -- Wrap long lines

opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Indent with 4 spaces
opt.softtabstop = 4 -- Insert 4 spaces when pressing <Tab>
opt.tabstop = 4

opt.breakindent = true -- Indent wrapped lines
opt.linebreak = true
opt.showbreak = string.rep(" ", 2)
opt.joinspaces = false -- Don't join lines with spaces at the end

-- Better splitting
opt.splitbelow = true -- Split new windows below the current one
opt.splitright = true -- Split new windoes right of the current one
opt.inccommand = "split" -- Show offscreen results in a preview window during :substitute

-- Folding
opt.foldmethod = "marker"
opt.modelines = 1
opt.foldlevel = 0

-- Searching
opt.ignorecase = true -- Ignore case when searching ..
opt.smartcase = true -- unless there is a capital letter in the query
opt.incsearch = true -- Show search results as you type
opt.hlsearch = true -- Highlight search results

-- Undo, Swap and Backup
opt.backup = false -- Disable permanent backups..
opt.writebackup = true -- but enable temporary backups
opt.dir = vim.fn.stdpath("data") .. "/cache/swap"
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/cache/undo"

-- Completion
opt.pumheight = 10 -- Only show 10 completion candidates
opt.pumblend = 10 -- Add transparency to the pummenu
opt.completeopt = { "menuone", "noselect" }

-- Command Line Completion
opt.wildignorecase = true
opt.wildoptions = "pum"
opt.wildignore:append("*.o,*~,*pycache*")

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
    tab = "──",
    nbsp = "␣",
    trail = "•",
    precedes = "«",
    extends = "»",
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
    vim.opt.grepprg = "rg --vimgrep --no-heading --hidden --smart-case --no-ignore-vcs"
    vim.opt.grepformat = {
        "%f:%l:%c:%m",
        "%f:%l:%m",
    }
end

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Disable builtin plugins
local builtin_plugins = {
    loaded_gzip = 1,
    loaded_zip = 1,
    loaded_zipPlugin = 1,
    loaded_tar = 1,
    loaded_tarPlugin = 1,
    loaded_getscript = 1,
    loaded_getscriptPlugin = 1,
    loaded_vimball = 1,
    loaded_vimballPlugin = 1,
    loaded_2html_plugin = 1,
    loaded_matchit = 1,
    loaded_matchparen = 1,
    loaded_logiPat = 1,
    loaded_rrhelper = 1,
    loaded_tutor_mode_plugin = 1,
    loaded_rplugin = 1,
    loaded_bugreport = 1,
    loaded_syntax = 1,
    loaded_spellfile_plugin = 1,
    loaded_python3_provider = 0,
    loaded_node_provider = 0,
    loaded_perl_provider = 0,
    loaded_ruby_provider = 0,
}

for k, v in pairs(builtin_plugins) do
    vim.g[k] = v
end
