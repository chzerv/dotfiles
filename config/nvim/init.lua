-----------------------------------------------
-- init.lua
-- Used to load other configs found in lua/
-----------------------------------------------

require('impatient')

-- Initialize packer
require('plugins/packer_init')

local modules = {
    'options',
    'mappings',
    'autocommands',
--    'plugins/nvim-gitsigns',
}

for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)
    if not ok then
        vim.notify("Module [" .. module .. "] failed to load." .. "\n\n" .. err)
    end
end
