-----------------------------------------------
-- init.lua
-- Used to load other configs found in lua/
-----------------------------------------------

local ok, impatient = pcall(require, "impatient")
if ok then
    impatient.enable_profile()
end

require("core")
require("core.autocommands")
require("core.abbreviations")
require("core.mappings")

-- NvChad
_G.lazy_load = function(plugin, timer)
    if plugin then
        timer = timer or 0
        vim.defer_fn(function()
            require("packer").loader(plugin)
        end, timer)
    end
end

-- packer_compiled exists, so there is no need to immediately load core.plugins
vim.defer_fn(function()
    require("core.plugins")
end, 0)
