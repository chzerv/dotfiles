-----------------------------------------------
-- Configuration for neogit
-- https://github.com/TimUntersberger/neogit
-----------------------------------------------

local neogit = require "neogit"

neogit.setup {
    auto_refresh = false,
    kind = "tab",
    commit_popup = {
        kind = "split",
    },
}

local map = vim.api.nvim_set_keymap

map('n', '<leader>gg', "<cmd> Neogit<CR>", { noremap = true, silent = true })
