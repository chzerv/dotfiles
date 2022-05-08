--------------------------------
-- Appearance configuration
--------------------------------

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

require('lualine').setup {
  options = {
    theme = 'onedark'
  }
}

opt.shortmess:append 'c' -- Supress messages when reaching end of pummenu
opt.shortmess:append 'I' -- Disable VIM intro
opt.cmdheight = 2 -- cmd window height
opt.laststatus = 2 -- Always show the statusline
opt.showcmd = true
opt.ruler = false

-- Visualize tabs, spaces, unwrapped text and non-breaking spaces {{{
opt.list = true
opt.listchars = {
    extends = '›',
    precedes = '‹',
    nbsp = '␣',
    tab = '▸ ', -- '» '
}
-- Don't show trailing whitespaces in insert mode
-- vim.cmd([[
--     augroup ListcharsTrail
--         autocmd!
--         autocmd InsertEnter * opt.listchars.trail = "•"
--         autocmd InsertLeave * opt.listchars.trail = ""
--     augroup END
-- ]])

-- Folding
opt.foldlevelstart = 99
opt.foldmethod = "marker"
