-----------------------------------------------
-- init.lua
-- Used to load other configs found in lua/
-----------------------------------------------

-- Initialize packer
require('packer_init')

require('core/core')
require('core/mappings')
require('core/appearance')
require('core/commands')

-- Load remaining vimscript configuration
vim.cmd(':so $HOME/.config/nvim/nolua.vim')

require('plugins/nvim-cmp')
require('plugins/nvim-lsp')
require('plugins/nvim-telescope')
require('plugins/nvim-snippy')
require('plugins/nvim-gitsigns')
