-----------------
-- Autocommands
-----------------

local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd
local opt = vim.opt
local opt_local = vim.opt_local
local fn = vim.fn

-- Highlight yanked text.
-- Replacement for https://github.com/machakann/vim-highlightedyank
local yank_group = augroup("TextYankGroup", { clear = true })

aucmd("TextYankPost", {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank({
            higroup = "WarningMsg",
            timeout = "200",
        })
    end,
    desc = "Highlight yanked text",
})

-- Disable numbers in terminal and nter insert mode.
-- This works upon starting a NEW terminal. If you want it to also apply to existing terminals, use the "TerminalEnter" event.
local terminal_group = augroup("TerminalGroup", { clear = true })

aucmd("TermOpen", {
    group = terminal_group,
    callback = function()
        opt_local.relativenumber = false
        opt_local.number = false
        vim.cmd("startinsert")
    end,
    desc = "Disable numbers and enter insert mode in the terminal",
})

-- Restore the cursorline to its last position in a file
-- https://github.com/famiu/dot-nvim
-- local no_cursor_restore_buftype = {
--     "quickfix",
--     "help",
--     "terminal",
-- }
--
-- local no_cursor_restore_fts = {
--     "gitcommit",
--     "gitrebase",
-- }
--
-- local cursor_group = augroup("CursorGroup", { clear = true })
--
-- aucmd("BufReadPost", {
--     group = cursor_group,
--     callback = function()
--         if fn.line([['"]]) >= 1
--             and fn.line([['"]]) <= fn.line("$")
--             and not vim.tbl_contains(no_cursor_restore_buftype, opt.buftype:get())
--             and not vim.tbl_contains(no_cursor_restore_fts, opt.filetype:get())
--         then
--             cmd([[normal! g`" | zz]])
--         end
--     end,
--     desc = "Restore cursor to its last position in a file",
-- })

-- Automatically create a non-existing directory when writing a new file
aucmd("BufWritePre", {
    group = augroup("MkNonExDir", { clear = true }),
    callback = function()
        local path = fn.expand("%:p:h")
        if fn.isdirectory(path) == 0 then
            fn.mkdir(path, "p")
        end
    end,
    desc = "Create non-existing dir when writing a new file"
})

-- Set formatoptions
local formatopt_group = augroup('CustomFormatOptions', {})

-- aucmd("BufEnter", {
--     group = formatopt_group,
--     pattern = '*',
--     callback = function()
--         vim.opt.formatoptions = vim.opt.formatoptions - 'o' + 'r' + 'c'
--     end,
-- })

aucmd("BufEnter", {
    group = formatopt_group,
    command = "set formatoptions-=cro"
})
