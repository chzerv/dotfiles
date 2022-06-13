local M = {}

M.kanagawa = function()
    require("kanagawa").setup({
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = true,
        specialException = true,
        transparent = true,
        -- Works really nice with laststatus = 3
        dimInactive = true,
        globalStatus = true,
        colors = {},
        overrides = {},
    })

    vim.cmd("colorscheme kanagawa")
end

return M
