-----------------
-- Autocommands
-----------------

local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd

-- Highlight yanked text.
-- Replacement for https://github.com/machakann/vim-highlightedyank
local yank_group = augroup("TextYankGroup", { clear = true })

aucmd("TextYankPost", {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank({
            higroup = 'WarningMsg',
            timeout = '200'
        })
    end,
    desc = "Highlight yanked text"
})

-- Disable numbers in terminal and nter insert mode.
-- This works upon starting a NEW terminal. If you want it to also apply to existing terminals, use the "TerminalEnter" event.
local terminal_group = augroup("TerminalGroup", { clear = true })

aucmd("TermOpen", {
    group = terminal_group,
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.cmd([[startinsert]])
    end,
    desc = "Disable numbers and enter insert mode in the terminal"
})

local cursor_group = augroup("CursorGroup", { clear = true })

aucmd("BufReadPost", {
    group = cursor_group,
    callback = function()
        vim.cmd([[
           if line("'\"") > 1 && line("'\"") <= line("$") |
               execute "normal g`\"" |
           endif
        ]])
    end,
    desc = "Restore cursor to its last position in a file"
})
