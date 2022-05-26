-----------------------------------------------
-- init.lua
-- Used to load other configs found in lua/
-----------------------------------------------

local ok, impatient = pcall(require, "impatient")
if ok then
    impatient.enable_profile()
end

require "core"
require "core.plugins"
require "core.autocommands"
require "core.abbreviations"
require "core.mappings"
