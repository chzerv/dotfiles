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

    vim.cmd.colorscheme("kanagawa")
end

M.kanagawa_colors = {
    bg = "#16161D",
    fg = "#C8C093",
    gray = "#2A2A37",
    blue = "#7E9CD8",
    green = "#76946A",
    red = "#C34043",
    cyan = "#6A9589",
    magenta = "#957FB8",
    darkmagenta = "#54546D",
    yellow = "#DCA561",
    orange = "#D18616",
}

M.tokyonight = function()
    require("tokyonight").setup({
        style = "night",
        transparent = true,
        terminal_colors = true,
        styles = {
            comments = "italic",
            keywords = "NONE",
            functions = "NONE",
            variables = "NONE",
            sidebars = "dark",
            floats = "dark",
        },
        sidebars = { "qf", "help", "packer", "terminal" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = true,
    })

    vim.cmd.colorscheme("tokyonight")
end

M.tokyonight_night_colors = {
    bg = "#1a1b26",
    fg = "#c0caf5",
    gray = "#565f89",
    blue = "#7E9CD8",
    green = "#9ece6a",
    red = "#f7768e",
    cyan = "#7dcfff",
    magenta = "#bb9af7",
    darkmagenta = "#9d7cd8",
    yellow = "#e0af68",
    orange = "#ff9e64",
}

return M
