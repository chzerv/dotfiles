-----------------------------------------------
-- init.lua
-- Used to load other configs found in lua/
-----------------------------------------------

-- Initialize packer
require('plugins/packer_init')

-- Core configuration {{{
require('core/core')
require('core/mappings')
require('core/appearance')
require('core/commands')
-- }}}

-- Load remaining vimscript configuration
vim.cmd(':so $HOME/.config/nvim/nolua.vim')

-- Plugins {{{
require('plugins/nvim-cmp')
require('plugins/nvim-lsp')
require('plugins/nvim-treesitter')
require('plugins/nvim-telescope')
require('plugins/nvim-snippy')
require('plugins/nvim-gitsigns')
require('plugins/nvim-comment')
require('plugins/nvim-autopairs')
require('plugins/nvim-indent-blankline')
require('plugins/appearance')
require('plugins/others')
-- }}}
