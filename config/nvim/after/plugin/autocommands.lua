-----------------
-- Autocommands
-----------------

-- Highlight yanked text.
-- Replacement for https://github.com/machakann/vim-highlightedyank
local yank_group = vim.api.nvim_create_augroup("TextYankGroup", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank({
            higroup = 'WarningMsg',
            timeout = '200'
        })
    end,
    desc = "Highlight yanked text"
})

-- Disable numbers in terminal
-- Enter insert mode upon starting a NEW terminal. If you want this to apply to existing
-- terminals, use the "TerminalEnter" event.
local terminal_group = vim.api.nvim_create_augroup("TerminalGroup", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
    group = terminal_group,
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.cmd([[startinsert]])
    end,
    desc = "Disable numbers and enter insert mode in the terminal"
})
