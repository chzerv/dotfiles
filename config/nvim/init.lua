-----------------------------------------------
-- init.lua
-- Used to load other configs found in lua/
-----------------------------------------------

local cmd = vim.cmd
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- Credits: https://github.com/famiu/
local function plugin_config()
    require "plugins"
    require "impatient"
    require "core"
    require "core.mappings"
end

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })

    cmd("packadd packer.nvim")

    -- Load plugins
    require "plugins"
    cmd("PackerSync")
    vim.api.nvim_create_autocmd("User PackerComplete", {
        -- group = vim.api.nvim_create_augroup("Packer", { clear = true }),
        once = true,
        callback = plugin_config
    })
else
    require "plugins"
    plugin_config()
end

