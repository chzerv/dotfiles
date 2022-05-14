-----------------------------------------------
-- init.lua
-- Used to load other configs found in lua/
-----------------------------------------------

-- Initialize packer
require('plugins/packer_init')

local modules = {
    'core/core',
    'core/mappings',
    'core/appearance',
    'core/autocommands',
    'plugins/nvim-cmp',
    'plugins/nvim-lsp',
    'plugins/nvim-treesitter',
    'plugins//nvim-telescope',
    'plugins/nvim-snippy',
    'plugins/nvim-gitsigns',
    'plugins/nvim-comment',
    'plugins/nvim-autopairs',
    'plugins/nvim-indent-blankline',
    'plugins/appearance',
    'plugins/others'
}

for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)
    if not ok then
        vim.notify("Module [" .. module .. "] failed to load." .. "\n\n" .. err)
    end
end

-- Load remaining vimscript configuration
vim.cmd(':so $HOME/.config/nvim/nolua.vim')

