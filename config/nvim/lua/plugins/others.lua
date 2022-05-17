---------------------------------------- ---------------------
-- Configuration that doesn't deserve to be in its own file
---------------------------------------- ---------------------

-- Disable built-in tmux-navigator mappings
vim.g.tmux_navigator_no_mappings = 1

-- Launch fugitive
vim.keymap.set('n', '<leader>gg', function()
    vim.cmd([[
        :tabnew | Git
        wincmd o
    ]])
end, { noremap = true, silent = true })
