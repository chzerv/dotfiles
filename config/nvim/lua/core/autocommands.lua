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

-- https://this-week-in-neovim.org/2023/Jan/2#tips
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        if vim.bo.filetype ~= "gitcommit" then
            local mark = vim.api.nvim_buf_get_mark(0, "\"")
            local lcount = vim.api.nvim_buf_line_count(0)
            if mark[1] > 0 and mark[1] <= lcount then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
        end
    end,
    group = vim.api.nvim_create_augroup("RestoreCursorGroup", { clear = true }),
})

-- Automatically create a non-existing directory when writing a new file
aucmd("BufWritePre", {
    group = augroup("MkNonExDir", { clear = true }),
    callback = function()
        local path = fn.expand("%:p:h")
        if fn.isdirectory(path) == 0 then
            fn.mkdir(path, "p")
        end
    end,
    desc = "Create non-existing dir when writing a new file",
})

-- Set formatoptions
local formatopt_group = augroup("CustomFormatOptions", {})

-- aucmd("BufEnter", {
--     group = formatopt_group,
--     pattern = '*',
--     callback = function()
--         vim.opt.formatoptions = vim.opt.formatoptions - 'o' + 'r' + 'c'
--     end,
-- })

aucmd("BufEnter", {
    group = formatopt_group,
    command = "set formatoptions-=cro",
})
