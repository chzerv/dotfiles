if vim.bo.filetype ~= 'gitcommit' then
    return
end

-- When editing a git commit message, enable spell check and create a split wit the diff.
local git_commit_group = vim.api.nvim_create_augroup("GitCommit", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = git_commit_group,
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
        vim.cmd('vertical Git diff --cached') -- Git is a vim-fugitive command
        vim.opt_local.filetype = "diff"
        vim.opt_local.swapfile = true
        vim.opt_local.modified = false
        vim.opt_local.readonly = true
        vim.cmd('wincmd l') -- Move the diff to the right
        vim.cmd('wincmd p') -- Go back to the previous window
    end
})
