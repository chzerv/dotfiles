-----------------------------------------------
-- init.lua
-- Used to load other configs found in lua/
-----------------------------------------------

require('impatient')

-- Initialize packer
require('plugins/packer_init')

local modules = {
    'core/core',
    'core/mappings',
    'core/appearance',
    'core/autocommands',
--    'plugins/nvim-gitsigns',
    'plugins/appearance',
}

for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)
    if not ok then
        vim.notify("Module [" .. module .. "] failed to load." .. "\n\n" .. err)
    end
end

-- Load remaining vimscript configuration
vim.cmd(':so $HOME/.config/nvim/nolua.vim')

