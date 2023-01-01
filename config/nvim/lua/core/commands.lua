vim.api.nvim_create_user_command("Source", function()
    if vim.bo.filetype == "vim" then
        vim.cmd([[
        silent! write
        source %
        ]])
    elseif vim.bo.filetype == "lua" then
        vim.cmd([[
        silent! write
        luafile %
        ]])
    end
end, {})
