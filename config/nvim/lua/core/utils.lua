-- Credits go to TJ Devries
-- https://github.com/tjdevries/config_manager/blob/8f14ab2dd6ba40645af196cc40116b55c0aca3c0/xdg_config/nvim/lua/tj/keymap.lua

local M = {}

M.imap = function(tbl)
    vim.keymap.set("i", tbl[1], tbl[2], tbl[3])
end

M.nmap = function(tbl)
    vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

return M
