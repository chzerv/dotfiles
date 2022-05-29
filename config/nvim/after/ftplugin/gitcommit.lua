if vim.bo.filetype ~= 'gitcommit' then
    return
end

-- Enable spell check when writing git commits
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.api.nvim_win_set_cursor(0, {1, 0})
