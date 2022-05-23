require('kanagawa').setup({
    undercurl = true,
    commentStyle = "italic",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    specialReturn = true,
    specialException = true,
    transparent = false,
    -- Works really nice with laststatus = 3
    dimInactive = true,
    globalStatus = true,
    colors = {},
    overrides = {},
})

vim.cmd("colorscheme kanagawa")
