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

M.kanagawa_colors = {
    bg = "#16161D",
    fg = "#C8C093",
    gray = "#2A2A37",
    blue = "#7E9CD8",
    green = "#76946A",
    red = "#C34043",
    bar = "#C34043",
    cyan = "#6A9589",
    magenta = "#957FB8",
    darkmagenta = "#54546D",
    yellow = "#DCA561",
    orange = "#D18616",
}
return M
