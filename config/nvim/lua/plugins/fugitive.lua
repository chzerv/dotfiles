return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit", "Gclog", "Gedit", "Gsplit", "Gread" },
        keys = {
            {
                "<leader>gg",
                function()
                    vim.cmd([[
                    :tabnew | Git
                    wincmd o
                    ]])
                end,
            },
        },
    },
}
