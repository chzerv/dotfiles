--------------------------------
-- Appearance configuration
--------------------------------

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

opt.shortmess:append 'c' -- Supress messages when reaching end of pummenu
opt.shortmess:append 'I' -- Disable VIM intro
opt.cmdheight = 2 -- cmd window height
opt.laststatus = 2 -- Always show the statusline
opt.showcmd = true
opt.ruler = false
-- opt.pumblend = 15 -- Add some transparency to the pummenu
opt.pumheight = 12 -- Limit how many completion candidates can appear in the pummenu

-- Visualize tabs, spaces, unwrapped text and non-breaking spaces {{{
opt.list = true
opt.listchars = {
    extends = '›',
    precedes = '‹',
    nbsp = '␣',
    tab = '▸ ', -- '» '
}
-- Don't show trailing whitespaces in insert mode
vim.cmd([[
    augroup ListcharsTrail
        autocmd!
        autocmd InsertEnter * :set listchars-=trail:•
        autocmd InsertLeave * :set listchars+=trail:•
    augroup END
]])

-- Folding
opt.foldlevelstart = 99
opt.foldmethod = "marker"

-- Only show the cursor line in the active buffer, and only when in normal mode.
-- (testing Lua autocmds)
local cursor_line_group = vim.api.nvim_create_augroup("CursorLine", { clear = true })
local set_cursorline = function(event, value)
    vim.api.nvim_create_autocmd(event, {
        group = cursor_line_group,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end

set_cursorline({ "WinLeave", "InsertEnter" }, false)
set_cursorline({ "BufEnter", "InsertLeave" }, true)

