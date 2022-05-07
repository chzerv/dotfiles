--------------------------------
-- Main configuration
--------------------------------

local fn = vim.fn
local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)
local map = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_command

-- Initialize packer
require('packer_init')

vim.cmd(':so $HOME/.config/nvim/nolua.vim')

-- Appearance {{{
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
-- }}}

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

require('plugins/nvim-cmp')
require('plugins/nvim-lsp')
require('plugins/nvim-telescope')
require('plugins/nvim-luasnip')
require('plugins/nvim-gitsigns')
